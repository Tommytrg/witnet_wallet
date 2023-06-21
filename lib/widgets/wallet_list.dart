import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wit_wallet/constants.dart';
import 'package:my_wit_wallet/screens/create_wallet/bloc/api_create_wallet.dart';
import 'package:my_wit_wallet/screens/create_wallet/bloc/create_wallet_bloc.dart';
import 'package:my_wit_wallet/screens/create_wallet/create_wallet_screen.dart';
import 'package:my_wit_wallet/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_wit_wallet/shared/locator.dart';
import 'package:my_wit_wallet/util/storage/database/account.dart';
import 'package:my_wit_wallet/widgets/PaddedButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wit_wallet/shared/api_database.dart';
import 'package:my_wit_wallet/util/storage/database/wallet.dart';
import 'package:my_wit_wallet/util/storage/database/wallet_storage.dart';
import 'package:my_wit_wallet/util/extensions/num_extensions.dart';
import 'package:my_wit_wallet/widgets/select_wallet_box.dart';

class ListItem {
  bool isSelected = false;
  String data;

  ListItem(this.data);
}

class WalletList extends StatefulWidget {
  const WalletList({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => WalletListState();
}

class WalletListState extends State<WalletList> {
  List<String> walletIdList = [];
  Wallet? selectedWallet;
  Account? selectedAccount;
  Map<String, dynamic>? selectedAddressList;
  late Function onSelected;
  ApiDatabase database = Locator.instance.get<ApiDatabase>();
  @override
  void initState() {
    super.initState();
    _getCurrentWallet();
    _getWallets();
    _getSelectedAccount();
    _setDashboardState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getCurrentWallet() async {
    WalletStorage walletStorage = database.walletStorage;
    setState(() {
      selectedWallet = walletStorage.currentWallet;
    });
  }

  void _getSelectedAccount() {
    WalletStorage walletStorage = database.walletStorage;
    setState(() {
      selectedAccount = walletStorage.currentAccount;
    });
  }

  void _setDashboardState() {
    BlocProvider.of<DashboardBloc>(context).add(DashboardUpdateWalletEvent(
      currentWallet: selectedWallet,
      currentAddress: selectedAccount!.address,
    ));
  }

  void _getWallets() {
    WalletStorage walletStorage = database.walletStorage;
    setState(() {
      selectedWallet = walletStorage.currentWallet;
      selectedAddressList = walletStorage.currentAddressList;
      walletStorage.wallets.forEach((key, value) {
        walletIdList.add(value.id);
      });
    });
  }

  //Go to create or import wallet view
  void _createImportWallet() {
    Locator.instance<ApiCreateWallet>().setWalletType(WalletType.unset);
    BlocProvider.of<CreateWalletBloc>(context)
        .add(ResetEvent(WalletType.unset));
    Navigator.pushReplacementNamed(context, CreateWalletScreen.route);
  }

  Widget _buildInitialButtons() {
    return PaddedButton(
      padding: EdgeInsets.all(0),
      text: 'Create or import',
      onPressed: () => {
        _createImportWallet(),
      },
      icon: Icon(
        FontAwesomeIcons.circlePlus,
        size: 18,
      ),
      type: 'horizontal-icon',
    );
  }

  Widget _buildWalletItem(String walletId) {
    final isSelectedWallet = walletId == selectedWallet?.id;
    Wallet? currentWallet = database.walletStorage.wallets[walletId];
    String? balance =
        currentWallet!.balanceNanoWit().availableNanoWit.toString();
    String currentWalletAccount =
        database.walletStorage.currentAddressList![walletId]!;
    Map<int, Account>? accountsList = currentWallet.externalAccounts;
    int currentAccountIndex = int.parse(currentWalletAccount.split('/').last);
    String? address = accountsList[currentAccountIndex]?.address.toString();

    return SelectWalletBox(
      walletId: walletId,
      label: database.walletStorage.wallets[walletId]!.name,
      isSelected: isSelectedWallet,
      walletName: database.walletStorage.wallets[walletId]!.name,
      balance: num.parse(balance).standardizeWitUnits(
          inputUnit: WitUnit.nanoWit, outputUnit: WitUnit.Wit),
      address: address ?? '',
      onChanged: (walletId) => {
        setState(() {
          selectedWallet = database.walletStorage.wallets[walletId]!;
        }),
        BlocProvider.of<DashboardBloc>(context).add(DashboardUpdateWalletEvent(
            currentWallet: selectedWallet,
            currentAddress: selectedAccount!.address))
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: ListView(padding: EdgeInsets.all(8), children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_buildInitialButtons()]),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: walletIdList.length,
            itemBuilder: (context, index) {
              return _buildWalletItem(walletIdList[index]);
            },
          ),
        ]));
  }
}
