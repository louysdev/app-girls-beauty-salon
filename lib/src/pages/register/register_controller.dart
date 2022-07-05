import 'package:app_delivery_udemy/src/models/response_api.dart';
import 'package:app_delivery_udemy/src/models/user.dart';
import 'package:app_delivery_udemy/src/provider/users_provider.dart';
import 'package:app_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterController{

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future init(BuildContext context){
    this.context = context;
    usersProvider.init(context);
  }

  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();


    if (email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty || confirmPassword.isEmpty){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }
    
    if (confirmPassword != password){
      MySnackbar.show(context, 'Las contraseñas no coincides');
      return;
    }
    
    if (password.length < 6){
      MySnackbar.show(context, 'La contraseña debe tener por lo menos 6 caracteres');
      return;
    }

    User user =  new User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password
    );

    ResponseApi responseApi = await usersProvider.create(user);

    MySnackbar.show(context, responseApi.message);

    /*
     Hacer que la luego de registrarse se espere 3 segundo para luego volver,
     a la pantalla de login
     */
    if (responseApi.success) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, 'login');
      });
    }

    print('RESPUESTA: ${responseApi.toJson()}');

  }

  void back() {
    Navigator.pop(context);
  }

}