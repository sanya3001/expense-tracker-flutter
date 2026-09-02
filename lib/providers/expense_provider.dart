import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/transaction_model.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  final List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  //total income calculate
  double get totalIncome {
    return _transactions.where((tx) => tx.isIncome).fold(0.0, (sum, item) => sum + double.parse(item.amount));
  }

  double get totalExpense {
    return _transactions.where((tx) => !tx.isIncome).fold(0.0, (sum, item) => sum + double.parse(item.amount));
  }

  double get totalBalance {
    return totalIncome - totalExpense;
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }
}
