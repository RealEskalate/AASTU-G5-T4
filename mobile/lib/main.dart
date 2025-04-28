import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc_providers.dart';
import 'package:mobile/core/config/router.dart';
import 'package:mobile/core/services/service_locator.dart' as di;
import 'package:mobile/core/widgets/back_button_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/theme/theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.initServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MultiBlocProvider(
            providers: createBlocProviders(),
            child: BackButtonHandler(
              exitTitle: 'Exit A2SV Hub?',
              exitMessage: 'Are you sure you want to exit the application?',
              stayButtonText: 'Cancel',
              exitButtonText: 'Exit',
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: router,
              ),
            ),
          );
        },
      ),
    );
  }
}
