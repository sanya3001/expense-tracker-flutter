import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class ExpenseProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TransactionModel> _transactions = [];

  ExpenseProvider() {
    fetchTransactions();
  }

  List<TransactionModel> get transactions => _transactions;

  // Transactions Screen mate: All Expenses
  List<TransactionModel> get expenseTransactions =>
      _transactions.where((tx) => !tx.isIncome).toList();

  // Transactions Screen mate: All Income
  List<TransactionModel> get incomeTransactions =>
      _transactions.where((tx) => tx.isIncome).toList();

  // Home Screen mate: Today expenses
  List<TransactionModel> get todayExpenseTransactions {
    final now = DateTime.now();
    return _transactions.where((tx) {
      return !tx.isIncome &&
          tx.date.year == now.year &&
          tx.date.month == now.month &&
          tx.date.day == now.day;
    }).toList();
  }

  // Calculation properties
  double get totalIncome {
    return _transactions
        .where((tx) => tx.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((tx) => !tx.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance => totalIncome - totalExpense;

  void fetchTransactions() {
    _firestore
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((snapshot) {
      _transactions = snapshot.docs
          .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
          .toList();
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


