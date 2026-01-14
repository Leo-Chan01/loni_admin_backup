import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/provider/admin_auth_provider.dart';
import 'l10n/l10n_extensions.dart';
import 'shared/widgets/global_snackbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AdminAuthProvider()..loadSession(),
            ),
          ],
          child: Consumer<AdminAuthProvider>(
            builder: (context, auth, _) {
              return MaterialApp.router(
                onGenerateTitle: (context) => context.l10n.appTitle,
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                themeMode: ThemeMode.light,
                routerConfig: AppRoutes.createRouter(auth),
                scaffoldMessengerKey: GlobalSnackBar.scaffoldMessengerKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          ),
        );
      },
    );
  }
}
