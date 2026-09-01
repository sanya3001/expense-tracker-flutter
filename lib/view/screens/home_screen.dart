import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildBalanceCard(),
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildBalanceCard(),
              const SizedBox(height: 24),
              //   _buildMonthSummary(),
              //   const SizedBox(height: 24),
              //   _buildSpendingOverview(),
              //   const SizedBox(height: 24),
              //   _buildRecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Good Morning, Nexowa 👋",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 1)
            ],
          ),
          child: const Icon(Icons.tune, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
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
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                "₹ 45,230.50",
                style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "₹ 56,890.60",
                style: TextStyle(color: Colors.pink, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
          // Placeholder for Wallet Graphic on the right side
          Positioned(
            right: 0,
            top: 10,
            child: Icon(Icons.account_balance_wallet, color: Colors.yellow.withOpacity(0.5), size: 60),
          ),
        ],
      ),
    );
  }
}

