import 'package:app_delivery_udemy/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:app_delivery_udemy/src/utils/my_colors.dart';
import 'package:app_delivery_udemy/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({Key key}) : super(key: key);

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {

  ClientAddressListController _con = ClientAddressListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direcciones'),
        actions: [
          _iconAdd()
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            _textSelectAddress(),
            Container(
                margin: EdgeInsets.only(top: 30),
                child: NoDataWidget(text: 'No tienes ninguna direccion, agrega una nueva')
            ),
            _buttonNewAddress(),
          ],
        ),
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget _iconAdd() {
    return IconButton(
      onPressed: _con.goToNewAddress,
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'ACEPTAR'
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          primary: MyColors.primaryColor
        ),
      )
    );
  }

  Widget _buttonNewAddress() {
    return Container(
        height: 40,
        child: ElevatedButton(
          onPressed: _con.goToNewAddress,
          child: Text(
              'Nueva direccion'
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.blue
          ),
        )
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Elige donde recibir tus compras',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
