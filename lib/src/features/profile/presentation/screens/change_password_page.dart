import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../controller/profile_controller.dart';

import '../../../../core/widgets/widgets.dart';
import '../components/text_form_profile.dart';



class ChangePasswordPage extends StatefulWidget {

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  late TextEditingController _currentPasswordC;
  late TextEditingController _newPasswordC;
  late TextEditingController _newPasswordAgainC;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentPasswordC = TextEditingController();
    _newPasswordC = TextEditingController();
    _newPasswordAgainC = TextEditingController();

  }

  @override
  void dispose() {
    _currentPasswordC.dispose();
    _newPasswordC.dispose();
    _newPasswordAgainC.dispose();
    super.dispose();
  }

  void clear(){
    _currentPasswordC.clear();
    _newPasswordC.clear();
    _newPasswordAgainC.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const TextCustom(text: 'Password', fontSize: 19),
          elevation: 0,
          actions: [
            GetBuilder<ProfileController>(
              builder: (profileCtrl) {
                return TextButton(
                  onPressed: (){
                    if( _keyForm.currentState!.validate() ){
                      profileCtrl.changepassword(
                        _currentPasswordC.text.trim(), 
                        _newPasswordAgainC.text.trim(),
                        );
                    }
                  }, 
                  child: TextCustom(text: 'Keep', fontSize: 15, color: colorPrimary)
                );
              }
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
                      controller: _currentPasswordC, 
                      labelText: 'Current password',
                      validator: MultiValidator([
                        MinLengthValidator(6, errorText: 'Minimum 6 characters'),
                        RequiredValidator(errorText: 'The field cannot be empty')
                      ]),
                    ),
        
                    const SizedBox(height: 20.0),
                    TextFormProfile(
                      controller: _newPasswordC, 
                      labelText: 'New Password',
                      validator: MultiValidator([
                        MinLengthValidator(6, errorText: 'Minimum 6 characters'),
                        RequiredValidator(errorText: 'The field cannot be empty')
                      ]),
                    ),
        
                    const SizedBox(height: 20.0),
                    TextFormProfile(
                      controller: _newPasswordAgainC, 
                      labelText: 'Repeat password',
                      validator: MultiValidator([
                        MinLengthValidator(6, errorText: 'Minimum 6 characters'),
                        RequiredValidator(errorText: 'The field cannot be empty')
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