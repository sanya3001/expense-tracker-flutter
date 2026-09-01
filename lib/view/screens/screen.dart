// import 'package:flutter/material.dart';
// import '../models/transaction_model.dart';
// import '../models/category_model.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
//
//
//
//
//
// class _HomeScreenState extends State<HomeScreen> {
//   // Dummy Data for UI
//   final List<CategoryModel> categories = [
//     CategoryModel(name: "Home", percentage: "35%", color: Colors.blueAccent),
//     CategoryModel(name: "Food", percentage: "25%", color: Colors.amber),
//     CategoryModel(name: "Transport", percentage: "15%", color: Colors.lightBlue),
//     CategoryModel(name: "Education", percentage: "15%", color: Colors.orangeAccent),
//     CategoryModel(name: "Others", percentage: "10%", color: Colors.green),
//   ];
//
//   final List<TransactionModel> recentTransactions = [
//     TransactionModel(
//       title: "Grocery Shopping",
//       date: "Today, 08:30 AM",
//       amount: 1250.00,
//       iconPath: "🛒", // Use image assets in real app
//     ),
//     // Add more dummy transactions if needed
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FE), // Light background color from design
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 24),
//               _buildBalanceCard(),
//               const SizedBox(height: 24),
//               _buildMonthSummary(),
//               const SizedBox(height: 24),
//               _buildSpendingOverview(),
//               const SizedBox(height: 24),
//               _buildRecentTransactions(),
//             ],
//           ),
//         ),
//       ),
//       // Custom Bottom Navigation Bar
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color(0xFF4A3AFF),
//         shape: const CircleBorder(),
//         child: const Icon(Icons.add, color: Colors.white, size: 30),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }
//
//   // 1. Header Section
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Good Morning, Aarav 👋",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
//             ),
//             SizedBox(height: 4),
//             Text(
//               "Here's your family overview",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, spreadRadius: 1)
//             ],
//           ),
//           child: const Icon(Icons.tune, color: Colors.black87),
//         ),
//       ],
//     );
//   }
//
//   // 2. Total Balance Card
//   Widget _buildBalanceCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF5E4BFF), Color(0xFF8675FF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF5E4BFF).withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           )
//         ],
//       ),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Total Balance",
//                 style: TextStyle(color: Colors.white70, fontSize: 14),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "₹ 45,230.50",
//                 style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   const Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 16),
//                   const SizedBox(width: 4),
//                   const Text(
//                     "12.5% vs last month",
//                     style: TextStyle(color: Colors.white70, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           // Placeholder for Wallet Graphic on the right side
//           Positioned(
//             right: 0,
//             top: 10,
//             child: Icon(Icons.account_balance_wallet, color: Colors.white.withOpacity(0.5), size: 60),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 3. This Month Summary (Income / Expense)
//   Widget _buildMonthSummary() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("This Month Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: _summaryCard("Income", "₹ 72,450", Colors.green),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               child: _summaryCard("Expense", "₹ 27,219", Colors.redAccent),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _summaryCard(String title, String amount, Color amountColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: amountColor == Colors.green ? const Color(0xFFE8F7F0) : const Color(0xFFFCEAEA),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           const SizedBox(height: 8),
//           Text(
//             amount,
//             style: TextStyle(color: amountColor, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 4. Spending Overview
//   Widget _buildSpendingOverview() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Spending Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             children: [
//               // Dummy Donut Chart (Use fl_chart in production)
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.blueAccent, width: 12),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text("₹ 27,219", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                       Text("Total", style: TextStyle(color: Colors.grey, fontSize: 10)),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 20),
//               // Legend
//               Expanded(
//                 child: Column(
//                   children: categories.map((cat) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(backgroundColor: cat.color, radius: 4),
//                           const SizedBox(width: 8),
//                           Expanded(child: Text(cat.name, style: const TextStyle(fontSize: 12))),
//                           Text(cat.percentage, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // 5. Recent Transactions
//   Widget _buildRecentTransactions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Recent Transactions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 12),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: recentTransactions.length,
//           itemBuilder: (context, index) {
//             final tx = recentTransactions[index];
//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(tx.iconPath, style: const TextStyle(fontSize: 20)),
//                 ),
//                 title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text(tx.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                 trailing: Text(
//                   "₹ ${tx.amount.toStringAsFixed(0)}",
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
//
//   // 6. Bottom Navigation Bar
//   Widget _buildBottomNavigationBar() {
//     return BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 8.0,
//       color: Colors.white,
//       child: SizedBox(
//         height: 60,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(Icons.home_filled, "Home", true),
//             _buildNavItem(Icons.list_alt, "Transactions", false),
//             const SizedBox(width: 40), // Space for FAB
//             _buildNavItem(Icons.account_balance_wallet_outlined, "Budget", false),
//             _buildNavItem(Icons.more_horiz, "More", false),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String label, bool isActive) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: isActive ? const Color(0xFF4A3AFF) : Colors.grey),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: isActive ? const Color(0xFF4A3AFF) : Colors.grey,
//             fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//           ),
//         )
//       ],
//     );
//   }
// }
