import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../utils/app_colors.dart';

class ExpenseProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<TransactionModel> _transactions = [];
  String? _familyId;

  ExpenseProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        initFamilyAndFetch(user);
      } else {
        clearData();
      }
    });
  }

  List<TransactionModel> get transactions => _transactions;
  String? get familyId => _familyId;

  List<TransactionModel> get expenseTransactions => _transactions.where((tx) => !tx.isIncome).toList();

  List<TransactionModel> get incomeTransactions => _transactions.where((tx) => tx.isIncome).toList();

  List<TransactionModel> get todayExpenseTransactions {
    final now = DateTime.now();
    return _transactions.where((tx) {
      return !tx.isIncome && tx.date.year == now.year && tx.date.month == now.month && tx.date.day == now.day;
    }).toList();
  }

  double get totalIncome => _transactions.where((tx) => tx.isIncome).fold(0.0, (sum, item) => sum + item.amount);

  double get totalExpense => _transactions.where((tx) => !tx.isIncome).fold(0.0, (sum, item) => sum + item.amount);

  double get totalBalance => totalIncome - totalExpense;

  List<CategoryModel> get categorySpendingList {
    final expenses = expenseTransactions;
    final total = totalExpense;

    if (total == 0 || expenses.isEmpty) return [];

    final Map<String, Color> categoryColors = {'Home': AppColors.catHome, 'Food': AppColors.catFood, 'Transport': AppColors.catTransport, 'Education': AppColors.catEducation, 'Health': Colors.pinkAccent, 'Shopping': Colors.purpleAccent, 'Bills': Colors.cyan, 'Others': AppColors.catOthers};

    Map<String, double> categorySums = {};
    for (var tx in expenses) {
      categorySums[tx.category] = (categorySums[tx.category] ?? 0.0) + tx.amount;
    }

    List<CategoryModel> list = [];
    categorySums.forEach((categoryName, amount) {
      double pct = (amount / total) * 100;
      list.add(CategoryModel(name: categoryName, percentage: "${pct.toStringAsFixed(1)}%", color: categoryColors[categoryName] ?? AppColors.catOthers));
    });

    list.sort((a, b) => double.parse(b.percentage.replaceAll('%', '')).compareTo(double.parse(a.percentage.replaceAll('%', ''))));

    return list;
  }

  // 1. login user ni familyId find karvi
  Future<void> initFamilyAndFetch(User user) async {
    try {
      final userEmail = (user.email ?? '').trim().toLowerCase();

      final inviteQuery = await _firestore.collection('family_members').where('email', isEqualTo: userEmail).limit(1).get();

      if (inviteQuery.docs.isNotEmpty) {
        _familyId = inviteQuery.docs.first.data()['familyId'];
      } else {
        _familyId = user.uid;
      }

      fetchTransactions();
    } catch (e) {
      debugPrint("Error finding familyId in expense provider: $e");
      _familyId = user.uid;
      fetchTransactions();
    }
  }

  void fetchTransactions() {
    if (_familyId == null) {
      _transactions = [];
      notifyListeners();
      return;
    }

    _firestore
        .collection('transactions')
        .where('familyId', isEqualTo: _familyId)
        .snapshots()
        .listen(
          (snapshot) {
            _transactions = snapshot.docs.map((doc) => TransactionModel.fromMap(doc.data(), doc.id)).toList();

            _transactions.sort((a, b) => b.date.compareTo(a.date));
            notifyListeners();
          },
          onError: (error) {
            debugPrint("Expense fetch error: $error");
          },
        );
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    final user = _auth.currentUser;
    if (_familyId == null && user != null) {
      await initFamilyAndFetch(user);
    }

    if (_familyId == null) return;

    try {
      final data = transaction.toMap();
      data['familyId'] = _familyId;

      await _firestore.collection('transactions').add(data);
    } catch (e) {
      debugPrint("Error saving transaction: $e");
    }
  }

  void clearData() {
    _transactions = [];
    _familyId = null;
    notifyListeners();
  }
}
