import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id;
  final String title;
  final DateTime date;
  final double amount;
  final String iconPath;
  final bool isIncome;
  final String category;

  TransactionModel({
    this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.iconPath,
    required this.isIncome,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': Timestamp.fromDate(date),
      'amount': amount,
      'iconPath': iconPath,
      'isIncome': isIncome,
      'category': category,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map, String docId) {
    return TransactionModel(
      id: docId,
      title: map['title'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      amount: (map['amount'] as num).toDouble(),
      iconPath: map['iconPath'] ?? '💰',
      isIncome: map['isIncome'] ?? false,
      category: map['category'] ?? 'Others',
    );
  }
}
