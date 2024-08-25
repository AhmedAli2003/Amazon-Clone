import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/functions/validators.dart';
import '../../../core/common/widgets/custom_text_form_field.dart';
import '../../../core/models/sign_in_request.dart';
import '../../../core/models/sign_up_request.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import 'auth_button.dart';
import 'auth_title.dart';
import 'password_text_form_field.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final FocusNode nameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  late final FocusScopeNode globalNode;

  late final PageController pageController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    globalNode = FocusScopeNode();

    pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = pageController.page ?? 0;
        });
      });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    globalNode.dispose();

    pageController.dispose();
    super.dispose();
  }

  bool clickedOnce = true;

  void onChange(String? _) {
    if (progress == 0) {
      signInFormKey.currentState?.validate();
    } else {
      signUpFormKey.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          height: 300 + progress * 70,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: PageView(
            controller: pageController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FocusScope(
                  node: globalNode,
                  child: Form(
                    key: signInFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const AuthTitle('SIGN IN'),
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
                          AuthButton(onTap: signIn, text: 'Sign In'),
                          TextButton(
                            onPressed: goToSignUp,
                            child: const Text('Don\'t have an account?'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: signUpFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AuthTitle('SIGN UP'),
                        const SizedBox(height: 12),
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
                        AuthButton(onTap: signUp, text: 'Sign Up'),
                        TextButton(
                          onPressed: goToSignIn,
                          child: const Text('Already have an account?'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void signIn() {
    if (signInFormKey.currentState?.validate() ?? false) {
      globalNode.unfocus();
            ref.read(authControllerProvider).signIn(
            request: SignInRequest(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
            context: context,
          );
    }

    setState(() => clickedOnce = false);
  }

  void signUp() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      globalNode.unfocus();
      ref.read(authControllerProvider).signUp(
            request: SignUpRequest(
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
            context: context,
          );
    }
    setState(() => clickedOnce = false);
  }

  void goToSignIn() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToSignUp() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
