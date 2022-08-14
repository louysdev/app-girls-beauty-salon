import 'package:app_delivery_udemy/src/models/user.dart';
import 'package:app_delivery_udemy/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:app_delivery_udemy/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';


class ClientPaymentsCreatePage extends StatefulWidget {
  const ClientPaymentsCreatePage({Key key}) : super(key: key);

  @override
  State<ClientPaymentsCreatePage> createState() => _ClientPaymentsCreatePageState();
}

class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {

  ClientPaymentsCreateController _con = ClientPaymentsCreateController();

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
        title: Text('Pagos'),
      ),
      body: ListView(
        children: [
          CreditCardWidget(
            cardNumber: _con.cardNumber,
            expiryDate: _con.expireDate,
            cardHolderName: _con.cardHolderName,
            cvvCode: _con.cvvCode,
            showBackView: _con.isCvvFocuses,
            cardBgColor: MyColors.primaryColor,
            obscureCardNumber: true,
            obscureCardCvv: true,
            animationDuration: Duration(milliseconds: 1000),
            labelCardHolder: 'NOMBRE Y APELLIDO',
          ),
          CreditCardForm(
            formKey: _con.KeyForm, // Required
            onCreditCardModelChange: _con.onCreditCardModelChange, // Required
            themeColor: Colors.red,
            obscureCvv: true,
            obscureNumber: true,
            cardNumberDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Numero de la tarjeta',
              hintText: 'XXXX XXXX XXXX XXXX',
            ),
            expiryDateDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fecha de expiracion',
              hintText: 'XX/XX',
            ),
            cvvCodeDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            cardHolderDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre del titular',
            ),
          ),
          _documentInfo(),
          _buttonNext()
        ],
      ),
    );
  }

  Widget _documentInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        child: DropdownButton(
                          underline: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_drop_down_circle,
                              color: MyColors.primaryColor,
                            ),
                          ),
                          elevation: 3,
                          isExpanded: true,
                          hint: Text(
                            'C.C',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16
                            ),
                          ),
                          items: _dropDownItems([]),
                          value: '',
                          onChanged: (option) {
                            setState(() {
                              print('Repartidor seleccionado: $option');
                              // _con.idDelivery = option; // ESTABLECIENDO A LA VARIABLE AL ID CATEGORY
                            });
                          },
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            flex: 4,
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Numero de documento'
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<User> users) {

    List<DropdownMenuItem<String>> list = [];
    users.forEach((user) {
      list.add(DropdownMenuItem(
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              child: FadeInImage(
                image: user.image != null
                    ? NetworkImage(user.image)
                    : ('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ),
            SizedBox(width: 5),
            Text(user.name)
          ],
        ),
        value: user.id,
      ));
    });

    return list;
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'CONTINUAR',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 50, top: 7),
                  height: 30,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 30,
                  )
              ),
            )

          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {

    });
  }

}
