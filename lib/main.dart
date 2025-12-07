import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme_provider.dart';
import 'features/calculator/data/repositories/calculator_repository_impl.dart';
import 'features/calculator/domain/repositories/calculator_repository.dart';
import 'features/calculator/domain/usecases/calculate_expression_usecase.dart';
import 'features/calculator/presentation/manager/calculator_controller.dart';
import 'features/calculator/presentation/pages/calculator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<CalculatorRepository>(
            create: (_) => CalculatorRepositoryImpl()),
        Provider<CalculateExpressionUseCase>(
          create: (context) => CalculateExpressionUseCase(
            context.read<CalculatorRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CalculatorController(
            context.read<CalculateExpressionUseCase>(),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Calculator',
            theme: ThemeData(
              useMaterial3: true,
              brightness:
                  themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            home: const CalculatorScreen(),
          );
        },
      ),
    );
  }
}
