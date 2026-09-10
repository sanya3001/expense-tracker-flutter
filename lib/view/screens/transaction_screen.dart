
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/expense_provider.dart';
import '../../utils/app_colors.dart';
import '../../models/transaction_model.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool _showExpenses = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    // All Expenses / All Income
    final List<TransactionModel> displayList =
    _showExpenses ? provider.expenseTransactions : provider.incomeTransactions;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textMain, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Transactions",
          style: TextStyle(
            color: AppColors.textMain,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Top Toggle Buttons
            Container(
              height: 46,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEBFA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showExpenses = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _showExpenses ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "All Expenses",
                          style: TextStyle(
                            color: _showExpenses ? Colors.white : AppColors.textMuted,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showExpenses = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: !_showExpenses ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "All Income",
                          style: TextStyle(
                            color: !_showExpenses ? Colors.white : AppColors.textMuted,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // List of Transactions
            Expanded(
              child: displayList.isEmpty
                  ? Center(
                child: Text(
                  _showExpenses ? "No Expenses Added" : "No Income Added",
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              )
                  : ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final tx = displayList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: tx.isIncome
                              ? AppColors.incomeBg
                              : AppColors.expenseBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(tx.iconPath,
                            style: const TextStyle(fontSize: 22)),
                      ),
                      title: Text(
                        tx.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textMain),
                      ),
                      subtitle: Text(
                        DateFormat('dd MMM yyyy').format(tx.date),
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 12),
                      ),
                      trailing: Text(
                        "${tx.isIncome ? '+' : '-'} ₹ ${tx.amount.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: tx.isIncome
                              ? AppColors.incomeText
                              : AppColors.expenseText,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}





