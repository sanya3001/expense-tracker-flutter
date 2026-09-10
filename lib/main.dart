import 'package:expense_tracker/providers/family_provider.dart';
import 'package:expense_tracker/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/app_colors.dart';
import 'providers/expense_provider.dart';


void main() async {
  // 1. Flutter binding initialize
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Firebase Initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ExpenseProvider()),
          ChangeNotifierProvider(create: (_) => FamilyProvider()),

    ],
      child: const FamilyExpenseApp(),
    )
  );
}

class FamilyExpenseApp extends StatelessWidget {
  const FamilyExpenseApp({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
