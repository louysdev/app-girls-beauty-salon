import 'package:app_girls_beauty_salon/src/models/rol.dart';
import 'package:app_girls_beauty_salon/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {

  RolesController _con = new RolesController();

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
        title: Text('Seleccion un rol'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
          children: _con.user != null ? _con.user.roles.map((Rol rol) {
            return _cardRol(rol);
          }).toList() : []
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol){
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route);
      },
      child: Column(
          children: [
            Container(
              height: 100,
              child: FadeInImage(
                image: rol.image != null
                    ? NetworkImage(rol.image)
                    : AssetImage('assets/img/no-image.png'),
                fit: BoxFit.contain,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ),
            SizedBox(height: 15),
            Text(
              rol.name ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black
              ),
            ),
            SizedBox(height: 30),
          ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}
