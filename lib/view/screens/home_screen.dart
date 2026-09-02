import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 25),
              _buildBalanceCard(),
              const SizedBox(height: 28),
              const SizedBox(height: 24),
              _buildMonthSummary(),
              const SizedBox(height: 24),
              _buildSpendingOverview(),
              const SizedBox(height: 24),
              // _buildRecentTransactions(),
              // const SizedBox(height: 30), // Bottom scroll space
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 26),

              //   _buildMonthSummary(),
              //   const SizedBox(height: 24),
              //   _buildSpendingOverview(),
              //   const SizedBox(height: 24),
              //   _buildRecentTransactions(),
            ],
          ),
        ),
      ),

      // Center Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Expense code
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

  // 1. Header Section
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hello Sanya! Welcome to Home",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              "Here's your family overview",
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
            Text(
              "Here's your company overview",
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ],
        ),
        // Logout Button for testing
        GestureDetector(
          onTap: () async {
            await AuthService().logout();
            if (context.mounted) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          },
          child: Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: Colors.pinkAccent,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 8)
    ],
    ),
    child: const Icon(Icons.tune, color: Colors.black87),
    ),
        ),
      ],
    );
  }

  // 2. Total Balance Card
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.yellow, Colors.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent,
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
      ),

      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Balance",
                style: TextStyle(
                  color: Color(0xFFE0E0E0), // Light grey text
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "₹ 45,230.50",
                style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Text(
                "₹ 56,890.60",
                style: TextStyle(color: Colors.pink, fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    "12.5% vs last month",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          // Background Wallet Icon
          Positioned(
            right: 0,
            top: 10,
            child: Icon(Icons.account_balance_wallet, color: Colors.yellow.withOpacity(0.5), size: 60),
          ),
        ],
      ),
    );
  }

  // 3. This Month Summary
  Widget _buildMonthSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("This Month Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain)),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _summaryCard("Income", "₹ 72,450", AppColors.incomeBg, AppColors.incomeText)), const SizedBox(width: 15), Expanded(child: _summaryCard("Expense", "₹ 27,219", AppColors.expenseBg, AppColors.expenseText))]),
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

  // 4. Spending Overview
  Widget _buildSpendingOverview() {
    return Container();
  }

  //5.

  // 6. Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, -5))]),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: AppColors.white,
        elevation: 0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home_filled, "Home", true),
              _buildNavItem(Icons.list_alt, "Transactions", false),
              const SizedBox(width: 40),
              _buildNavItem(Icons.account_balance_wallet_outlined, "Budget", false),
              _buildNavItem(Icons.more_horiz, "More", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {},
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: isActive ? AppColors.primary : AppColors.textMuted, size: 26), const SizedBox(height: 4), Text(label, style: TextStyle(fontSize: 10, color: isActive ? AppColors.primary : AppColors.textMuted, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal))]),
    );
  }
}
