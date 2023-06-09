import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/viewmodels/auth/register_viewmodel.dart';
import 'package:xeno_chat/widgets/xeno_button.dart';
import 'package:xeno_chat/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/widgets/xeno_textfield.dart';
import '../../services/xeno_form_validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String id = 'register-view';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel registerViewModel = RegisterViewModel();

  @override
  void dispose() {
    registerViewModel.firstNameController.dispose();
    registerViewModel.lastNameController.dispose();
    registerViewModel.emailController.dispose();
    registerViewModel.emailConfirmationController.dispose();
    registerViewModel.passwordController.dispose();
    registerViewModel.passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        registerViewModel;
      },
      child: XenoScaffold(
        appBarTitle: 'Create Account',
        body: Form(
          key: registerViewModel.registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140.h,),
              XenoTextField(
                controller: registerViewModel.firstNameController,
                title: 'First Name',
                validator: XenoFormValidator.firstNameValidator,
              ),
              XenoTextField(
                controller: registerViewModel.lastNameController,
                title: 'Last Name',
                validator: XenoFormValidator.lastNameValidator,
              ),
              XenoTextField(
                controller: registerViewModel.emailController,
                title: 'Email',
                validator: XenoFormValidator.emailAddressValidator,
              ),
              XenoTextField(
                controller: registerViewModel.emailConfirmationController,
                title: 'Email Confirmation',
                validator: (val) => MatchValidator(errorText: 'Emails do not match.').validateMatch(
                    val!,
                    registerViewModel.emailController.text
                ),
              ),
              XenoTextField(
                controller: registerViewModel.passwordController,
                title: 'Password',
                validator: XenoFormValidator.passwordValidator,
                obscureText: true,
              ),
              XenoTextField(
                controller: registerViewModel.passwordConfirmationController,
                title: 'Password Confirmation',
                validator: (val) => MatchValidator(errorText: 'Passwords do not match.').validateMatch(
                    val!,
                    registerViewModel.passwordController.text
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  registerViewModel.validateAndCreateAccount(context);
                },
                child: XenoButton(
                  text: 'Register',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
