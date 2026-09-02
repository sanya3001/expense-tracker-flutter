class TransactionModel{
  final String title;
  final String date;
  final String amount;
  final String iconPath;
  final bool isIncome;
  final bool category;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.iconPath,
    required this.category,
    this.isIncome = false

  });
}