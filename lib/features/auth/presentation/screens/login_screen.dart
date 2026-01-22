import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/global_snackbar.dart';
import '../../../../shared/widgets/auth_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../provider/admin_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final auth = context.read<AdminAuthProvider>();
    final ok = await auth.signInWithPassword(
      identifier: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (ok) {
      context.go('/dashboard');
    } else {
      GlobalSnackBar.showError(auth.errorMessage ?? context.l10n.loginFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AdminAuthProvider>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                context.l10n.appTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                context.l10n.adminSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 48.h),
              AuthTextField(
                label: context.l10n.emailLabel,
                hintText: context.l10n.emailLabel,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              AuthTextField(
                label: context.l10n.passwordLabel,
                hintText: context.l10n.passwordLabel,
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 32.h),
              PrimaryButton(
                label: context.l10n.login,
                isLoading: auth.isLoading,
                onPressed: _login,
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
