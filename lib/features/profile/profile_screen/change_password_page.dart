import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_app/core/utils/app_colors.dart';

import '../../../core/widgets/widgets.dart';
import '../profile_widgets/text_form_profile.dart';



class ChangePasswordPage extends StatefulWidget {

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordAgainController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordAgainController = TextEditingController();

  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordAgainController.dispose();

    super.dispose();
  }

  void clear(){
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _newPasswordAgainController.clear();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Contraseña', fontSize: 19),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: (){
                if( _keyForm.currentState!.validate() ){
    
                  // userBloc.add( OnChangePasswordEvent(
                  //   _currentPasswordController.text.trim(), 
                  //   _newPasswordAgainController.text.trim()
                  // ));
    
                }
              }, 
              child: TextCustom(text: 'Guardar', fontSize: 15, color: AppColors.primary)
            )
          ],
        ),
        body: Form(
          key: _keyForm,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
        
                    TextFormProfile(
                      controller: _currentPasswordController, 
                      labelText: 'Contraseña actual',
                      validator: MultiValidator([
                        MinLengthValidator(8, errorText: 'Minimo 8 caracteres'),
                        RequiredValidator(errorText: 'El campo no puede estar vacio')
                      ]),
                    ),
        
                    const SizedBox(height: 20.0),
                    TextFormProfile(
                      controller: _newPasswordController, 
                      labelText: 'Nueva Contraseña',
                      validator: MultiValidator([
                        MinLengthValidator(8, errorText: 'Minimo 8 caracteres'),
                        RequiredValidator(errorText: 'El campo no puede estar vacio')
                      ]),
                    ),
        
                    const SizedBox(height: 20.0),
                    TextFormProfile(
                      controller: _newPasswordAgainController, 
                      labelText: 'Repetir contraseña',
                      validator: MultiValidator([
                        MinLengthValidator(8, errorText: 'Minimo 8 caracteres'),
                        RequiredValidator(errorText: 'El campo no puede estar vacio')
                      ]),
                    ),
        
                  ],
                ),
              ),
            ) 
          ),
        )
      );
    
  }
}