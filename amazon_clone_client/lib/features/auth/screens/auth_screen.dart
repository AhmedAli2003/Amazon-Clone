import 'package:flutter/material.dart';

import '../../../app/common/functions/validators.dart';
import '../../../app/common/widgets/custom_text_form_field.dart';
import '../../../app/common/widgets/expanded_section.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/password_text_form_field.dart';

enum _AuthState {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  _AuthState authState = _AuthState.signIn;

  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final FocusNode nameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool clickedOnce = true;

  void onChange(String? _) {
    if (authState == _AuthState.signIn) {
      signInFormKey.currentState?.validate();
    } else {
      signUpFormKey.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                RadioListTile.adaptive(
                  value: _AuthState.signUp,
                  groupValue: authState,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onChanged: (val) => setState(() => authState = val ?? authState),
                ),
                ExpandedSection(
                  expand: authState == _AuthState.signUp,
                  axisAlignment: -1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Form(
                      key: signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: nameController,
                            focusNode: nameFocusNode,
                            labelText: 'Username',
                            hintText: 'Enter your name...',
                            prefexIcon: const Icon(Icons.person_rounded),
                            validator: validateUsername,
                            onChanged: clickedOnce ? null : onChange,
                          ),
                          const SizedBox(height: 12),
                          CustomTextFormField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            labelText: 'Email',
                            hintText: 'Enter your email...',
                            prefexIcon: const Icon(Icons.email_rounded),
                            validator: validateEmail,
                            onChanged: clickedOnce ? null : onChange,
                          ),
                          const SizedBox(height: 12),
                          PasswordTextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            validator: validatePassword,
                            onChanged: clickedOnce ? null : onChange,
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              if (signUpFormKey.currentState?.validate() ?? false) {
                              } else {}
                              setState(() => clickedOnce = false);
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                RadioListTile.adaptive(
                  value: _AuthState.signIn,
                  groupValue: authState,
                  title: const Text(
                    'Sign-In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onChanged: (val) => setState(() => authState = val ?? authState),
                ),
                ExpandedSection(
                  expand: authState == _AuthState.signIn,
                  axisAlignment: -1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Form(
                      key: signInFormKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            labelText: 'Email',
                            hintText: 'Enter your email...',
                            prefexIcon: const Icon(Icons.email_rounded),
                            validator: validateEmail,
                            onChanged: clickedOnce ? null : onChange,
                          ),
                          const SizedBox(height: 12),
                          PasswordTextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            validator: validatePassword,
                            onChanged: clickedOnce ? null : onChange,
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              if (signInFormKey.currentState?.validate() ?? false) {
                              } else {}
                              setState(() => clickedOnce = false);
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
