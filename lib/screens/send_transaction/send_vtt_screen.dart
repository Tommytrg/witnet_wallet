import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:witnet_wallet/bloc/transactions/value_transfer/vtt_create/vtt_create_bloc.dart';
import 'package:witnet_wallet/shared/api_database.dart';
import 'package:witnet_wallet/shared/locator.dart';
import 'package:witnet_wallet/widgets/PaddedButton.dart';
import 'package:witnet_wallet/util/storage/database/wallet.dart';
import 'package:witnet_wallet/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:witnet_wallet/widgets/layouts/dashboard_layout.dart';
import 'package:witnet_wallet/widgets/step_bar.dart';
import 'package:witnet_wallet/widgets/witnet/transactions/value_transfer/create_dialog_box/vtt_builder/01_recipient_step.dart';
import 'package:witnet_wallet/widgets/witnet/transactions/value_transfer/create_dialog_box/vtt_builder/02_select_miner_fee.dart';
import 'package:witnet_wallet/widgets/witnet/transactions/value_transfer/create_dialog_box/vtt_builder/03_review_step.dart';

class CreateVttScreen extends StatefulWidget {
  static final route = '/create-vtt';
  @override
  CreateVttScreenState createState() => CreateVttScreenState();
}

enum VTTsteps {
  Transaction,
  MinerFee,
  Review,
}

class CreateVttScreenState extends State<CreateVttScreen>
    with TickerProviderStateMixin {
  Wallet? currentWallet;
  dynamic nextAction;
  dynamic nextStep;
  List<VTTsteps> stepListItems = VTTsteps.values.toList();
  Enum stepSelectedItem = VTTsteps.Transaction;
  int currentStepIndex = 0;
  late AnimationController _loadingController;
  ApiDatabase database = Locator.instance.get<ApiDatabase>();
  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _loadingController.forward();
    _getCurrentWallet();
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  _setNextAction(action) {
    if (mounted) {
      setState(() {
        nextAction = action;
      });
    }
  }

  void goToNextStep() {
    if ((currentStepIndex + 1) < stepListItems.length) {
      setState(() {
        currentStepIndex += 1;
        stepSelectedItem = stepListItems[currentStepIndex];
      });
    }
  }

  void _getCurrentWallet() {
    setState(() {
      currentWallet = database.walletStorage.currentWallet;
      BlocProvider.of<VTTCreateBloc>(context)
          .add(AddSourceWalletsEvent(currentWallet: currentWallet!));
    });
  }

  List<Widget> _actions() {
    return [
      PaddedButton(
          padding: EdgeInsets.only(bottom: 8),
          text: nextAction != null ? nextAction().label : 'Continue',
          type: 'primary',
          enabled: true,
          onPressed: () => {
                if (nextAction != null) {nextAction().action(), goToNextStep()},
              }),
    ];
  }

  Widget stepToBuild() {
    if (stepSelectedItem == VTTsteps.Transaction) {
      return RecipientStep(
        nextAction: _setNextAction,
        currentWallet: currentWallet!,
      );
    } else if (stepSelectedItem == VTTsteps.MinerFee) {
      return SelectMinerFeeStep(
        nextAction: _setNextAction,
        currentWallet: currentWallet!,
      );
    } else {
      return ReviewStep(
        nextAction: _setNextAction,
        currentWallet: currentWallet!,
      );
    }
  }

  Widget _buildSendVttForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBar(
            actionable: false,
            selectedItem: stepSelectedItem,
            listItems: stepListItems,
            onChanged: (item) => {
                  setState(() =>
                      {stepSelectedItem = item!, currentStepIndex = item.index})
                }),
        SizedBox(height: 16),
        stepToBuild(),
      ],
    );
  }

  BlocListener _dashboardBlocListener() {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (BuildContext context, DashboardState state) {
        if (state.status == DashboardStatus.Ready) {}
      },
      child: _dashboardBlocBuilder(),
    );
  }

  BlocBuilder _dashboardBlocBuilder() {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (BuildContext context, DashboardState state) {
      return DashboardLayout(
        dashboardChild: _vttCreateBlocListener(),
        actions: _actions(),
      );
    });
  }

  BlocListener _vttCreateBlocListener() {
    return BlocListener<VTTCreateBloc, VTTCreateState>(
      listener: (BuildContext context, VTTCreateState state) {
        print(state.vttCreateStatus);
      },
      child: _vttCreateBlocBuilder(),
    );
  }

  BlocBuilder _vttCreateBlocBuilder() {
    return BlocBuilder<VTTCreateBloc, VTTCreateState>(
        builder: (BuildContext context, VTTCreateState state) {
      return _buildSendVttForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VTTCreateBloc, VTTCreateState>(
        builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => false,
        child: _dashboardBlocListener(),
      );
    });
  }
}
