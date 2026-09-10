import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../utils/app_colors.dart';

class ExpenseProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TransactionModel> _transactions = [];

  ExpenseProvider() {
    fetchTransactions();
  }

  List<TransactionModel> get transactions => _transactions;

  // Transactions Screen mate: All Expenses
  List<TransactionModel> get expenseTransactions => _transactions.where((tx) => !tx.isIncome).toList();

  // Transactions Screen mate: All Income
  List<TransactionModel> get incomeTransactions => _transactions.where((tx) => tx.isIncome).toList();

  // Home Screen mate: Today expenses
  List<TransactionModel> get todayExpenseTransactions {
    final now = DateTime.now();
    return _transactions.where((tx) {
      return !tx.isIncome && tx.date.year == now.year && tx.date.month == now.month && tx.date.day == now.day;
    }).toList();
  }

  // Calculation properties
  double get totalIncome {
    return _transactions.where((tx) => tx.isIncome).fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions.where((tx) => !tx.isIncome).fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance => totalIncome - totalExpense;

  // Dynamic Spending Overview Categories
  List<CategoryModel> get categorySpendingList {
    final expenses = expenseTransactions;
    final total = totalExpense;

    if (total == 0 || expenses.isEmpty) {
      return [];
    }

    // Category colors mapping
    final Map<String, Color> categoryColors = {
      'Home': AppColors.catHome,
      'Food': AppColors.catFood,
      'Transport': AppColors.catTransport,
      'Education': AppColors.catEducation,
      'Health': Colors.pinkAccent,
      'Shopping': Colors.purpleAccent,
      'Bills': Colors.cyan,
      'Others': AppColors.catOthers,
    };

    // Category wise amount no sarvalo
    Map<String, double> categorySums = {};
    for (var tx in expenses) {
      categorySums[tx.category] = (categorySums[tx.category] ?? 0.0) + tx.amount;
    }

    // Percentage calculate karvu
    List<CategoryModel> list = [];
    categorySums.forEach((categoryName, amount) {
      double pct = (amount / total) * 100;
      list.add(CategoryModel(
        name: categoryName,
        percentage: "${pct.toStringAsFixed(1)}%",
        color: categoryColors[categoryName] ?? AppColors.catOthers,
      ));
    });

    // Moto kharch upar aave te mate sort karvu
    list.sort((a, b) {
      double pctA = double.parse(a.percentage.replaceAll('%', ''));
      double pctB = double.parse(b.percentage.replaceAll('%', ''));
      return pctB.compareTo(pctA);
    });

    return list;
  }


  void fetchTransactions() {
    _firestore.collection('transactions').orderBy('date', descending: true).snapshots().listen((snapshot) {
      _transactions = snapshot.docs.map((doc) => TransactionModel.fromMap(doc.data(), doc.id)).toList();
      notifyListeners();
    });
  }

  // Firestore ma save karva
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await _firestore.collection('transactions').add(transaction.toMap());
    } catch (e) {
      debugPrint("Error saving transaction: $e");
    }
  }
}
