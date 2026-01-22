import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/screen_size.dart';
import 'core/utilities/language_service.dart';
import 'core/utilities/theme_service.dart';
import 'features/auth/presentation/provider/admin_auth_provider.dart';
import 'l10n/l10n_extensions.dart';
import 'shared/widgets/locale_notifier.dart';
import 'shared/widgets/global_snackbar.dart';
import 'shared/widgets/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeService _themeService = ThemeService();
  final LanguageService _languageService = LanguageService();

  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadLocale();
  }

  Future<void> _loadTheme() async {
    final savedMode = await _themeService.getSavedThemeMode();
    if (!mounted) return;
    setState(() {
      _themeMode = savedMode;
    });
  }

  Future<void> _loadLocale() async {
    final savedLocale = await _languageService.getSavedLocale();
    if (!mounted) return;
    setState(() {
      _locale = savedLocale;
    });
  }

  Future<void> _toggleTheme() async {
    final nextMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    setState(() {
      _themeMode = nextMode;
    });
    await _themeService.saveThemeMode(nextMode);
  }

  Future<void> _changeLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
    await _languageService.saveLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return ScreenUtilInit(
              designSize: DesignSizeConfig().designSize(
                orientation: orientation,
                constraints: constraints,
              ),
              minTextAdapt: true,
              useInheritedMediaQuery: true,
              ensureScreenSize: true,
              rebuildFactor: (old, data) => true,
              builder: (context, child) {
                return LocaleNotifier(
                  locale: _locale,
                  onLocaleChange: _changeLocale,
                  child: ThemeNotifier(
                    themeMode: _themeMode,
                    onToggle: () {
                      _toggleTheme();
                    },
                    child: MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (_) => AdminAuthProvider()..loadSession(),
                        ),
                      ],
                      child: Consumer<AdminAuthProvider>(
                        builder: (context, auth, _) {
                          return MaterialApp.router(
                            onGenerateTitle: (context) => context.l10n.appTitle,
                            theme: AppTheme.instance.lightTheme(),
                            darkTheme: AppTheme.instance.darkTheme(),
                            themeMode: _themeMode,
                            locale: _locale,
                            routerConfig: AppRoutes.createRouter(auth),
                            scaffoldMessengerKey:
                                GlobalSnackBar.scaffoldMessengerKey,
                            debugShowCheckedModeBanner: false,
                            localizationsDelegates:
                                AppLocalizations.localizationsDelegates,
                            supportedLocales: AppLocalizations.supportedLocales,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
