class TransactionModel{
  final String title;
  final DateTime date;
  final double amount;
  final String iconPath;
  final bool isIncome;
  final String category;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.iconPath,
    required this.category,
    this.isIncome = false

  });
}