import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_app/core/utils/app_colors.dart';

import '../../../core/widgets/widgets.dart';
import '../profile_widgets/text_form_profile.dart';


class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({Key? key}) : super(key: key);

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {

  late TextEditingController _userController;
  late TextEditingController _descriptionController;
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  final _keyForm = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    // final userBloc = BlocProvider.of<UserBloc>(context).state;

    _userController = TextEditingController();
    _descriptionController = TextEditingController();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();

  }

  @override
  void dispose() {
    _userController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Actualizar perfil', fontSize: 19),
          elevation: 0,
          leading: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: (){
                if( _keyForm.currentState!.validate() ){
                  // userBloc.add( OnUpdateProfileEvent(
                  //   _userController.text.trim(), 
                  //   _descriptionController.text.trim(), 
                  //   _fullNameController.text.trim(), 
                  //   _phoneController.text.trim()
                  // ));
                }
              }, 
              child: TextCustom(text: 'Guardar', color: AppColors.primary, fontSize: 14)
            )
          ],
        ),
        body: Form(
          key: _keyForm,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
          
                const SizedBox(height: 20.0),
                TextFormProfile(
                  controller: _userController,
                  labelText: 'Usuario',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Usuario es requerido'),
                    MinLengthValidator(3, errorText: 'Minimo 3 caracteres')
                  ])
                ),
          
                const SizedBox(height: 10.0),
                TextFormProfile(
                  controller: _descriptionController,
                  labelText: 'Descripciòn',
                  maxLines: 3
                ),
                const SizedBox(height: 20.0),
                TextFormProfile(
                  controller: _emailController,
                  isReadOnly: true,
                  labelText: 'Correo Electronico',
                ),
          
                const SizedBox(height: 20.0),
                TextFormProfile(
                  controller: _fullNameController,
                  labelText: 'Fullname',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Nombre es requerido'),
                    MinLengthValidator(3, errorText: 'Minimo 3 caracteres')
                  ])
                ),
          
                const SizedBox(height: 20.0),
                TextFormProfile(
                  controller: _phoneController,
                  labelText: 'Telefono',
                  keyboardType: TextInputType.number,
                ),
          
          
              ],
            ),
          ),
        ),
      
    );
  }
}