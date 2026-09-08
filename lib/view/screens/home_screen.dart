import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/category_model.dart';
import '../../providers/expense_provider.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import 'add_expense_screen.dart';
import 'login_screen.dart';
import 'transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CategoryModel> categories = [
    CategoryModel(name: "Home", percentage: "35%", color: AppColors.catHome),
    CategoryModel(name: "Food", percentage: "25%", color: AppColors.catFood),
    CategoryModel(name: "Transport", percentage: "15%", color: AppColors.catTransport),
    CategoryModel(name: "Education", percentage: "15%", color: AppColors.catEducation),
    CategoryModel(name: "Others", percentage: "10%", color: AppColors.catOthers),
  ];

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildHeader(), const SizedBox(height: 24), _buildBalanceCard(expenseProvider), const SizedBox(height: 24), _buildMonthSummary(expenseProvider), const SizedBox(height: 24), _buildSpendingOverview(expenseProvider), const SizedBox(height: 24), _buildRecentTransactions(expenseProvider), const SizedBox(height: 30)]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpenseScreen()));
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.add, color: AppColors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text("Good Morning 👋", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)), SizedBox(height: 4), Text("Here's your family overview", style: TextStyle(fontSize: 14, color: AppColors.textMuted))]),
        GestureDetector(
          onTap: () async {
            await AuthService().logout();
            if (context.mounted) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          },
          child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, spreadRadius: 1)]), child: const Icon(Icons.logout, color: AppColors.expenseText, size: 20)),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(ExpenseProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primaryDark, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))]),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Balance", style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text("₹ ${provider.totalBalance.toStringAsFixed(2)}", style: const TextStyle(color: AppColors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppColors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.arrow_upward, color: Color(0xFF4CAF50), size: 14), SizedBox(width: 4), Text("Updated Balance", style: TextStyle(color: AppColors.white, fontSize: 12))]),
              ),
            ],
          ),
          Positioned(right: -10, top: 10, child: Icon(Icons.account_balance_wallet, color: AppColors.white.withOpacity(0.15), size: 80)),
        ],
      ),
    );
  }

  Widget _buildMonthSummary(ExpenseProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("This Month Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain)),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _summaryCard("Income", "₹ ${provider.totalIncome.toStringAsFixed(0)}", AppColors.incomeBg, AppColors.incomeText)), const SizedBox(width: 15), Expanded(child: _summaryCard("Expense", "₹ ${provider.totalExpense.toStringAsFixed(0)}", AppColors.expenseBg, AppColors.expenseText))]),
      ],
    );
  }

  Widget _summaryCard(String title, String amount, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.w500)), const SizedBox(height: 8), Text(amount, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold))]),
    );
  }

  Widget _buildSpendingOverview(ExpenseProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Spending Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 10, spreadRadius: 2)]),
          child: Row(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 45,
                        sections:
                            categories.map((cat) {
                              return PieChartSectionData(color: cat.color, value: double.parse(cat.percentage.replaceAll('%', '')), title: '', radius: 12);
                            }).toList(),
                      ),
                    ),
                    Column(mainAxisSize: MainAxisSize.min, children: [Text("₹ ${provider.totalExpense.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textMain)), const Text("Total", style: TextStyle(color: AppColors.textMuted, fontSize: 11))]),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      categories.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(children: [CircleAvatar(backgroundColor: cat.color, radius: 5), const SizedBox(width: 10), Expanded(child: Text(cat.name, style: const TextStyle(fontSize: 13, color: AppColors.textMuted))), Text(cat.percentage, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textMain))]),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Home Screen: Today Expense batavse
  Widget _buildRecentTransactions(ExpenseProvider provider) {
    final todayExpenses = provider.todayExpenseTransactions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recent Transactions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain)),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionsScreen()));
              },
              child: const Text("View All", style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (todayExpenses.isEmpty)
          Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 24), alignment: Alignment.center, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)), child: const Text("No expenses added today", style: TextStyle(color: AppColors.textMuted, fontSize: 14)))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: todayExpenses.length,
            itemBuilder: (context, index) {
              final tx = todayExpenses[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: const Color(0xFF000000).withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))]),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.expenseBg, borderRadius: BorderRadius.circular(12)), child: Text(tx.iconPath, style: const TextStyle(fontSize: 22))),
                  title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textMain)),
                  subtitle: Text("Today, ${DateFormat('hh:mm a').format(tx.date)}", style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  trailing: Text("- ₹ ${tx.amount.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.expenseText)),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, -5))]),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: AppColors.white,
        elevation: 0,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( child: _buildNavItem(Icons.home_filled, "Home", true, () {})),
              Expanded(child: _buildNavItem(Icons.list_alt, "History", false, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionsScreen()));
              })),
              const SizedBox(width: 48),
              Expanded( child: _buildNavItem(Icons.account_balance_wallet_outlined, "Budget", false, () {})),
              Expanded( child: _buildNavItem(Icons.more_horiz, "More", false, () {})),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return MaterialButton(
      minWidth: 40,
      onPressed: onTap,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: isActive ? AppColors.primary : AppColors.textMuted, size: 26), const SizedBox(height: 4), FittedBox(fit: BoxFit.scaleDown,child: Text(label,maxLines: 1, style: TextStyle(fontSize: 10, color: isActive ? AppColors.primary : AppColors.textMuted, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)))]),
    );
  }
}
