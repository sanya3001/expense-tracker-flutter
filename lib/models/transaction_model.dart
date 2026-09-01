class TransactionModel{
  final String title;
  final String date;
  final String amount;
  final String iconPath;
  final bool isIncome;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.iconPath,
    this.isIncome = false
  });
}