// import 'package:flutter/material.dart';
//
// class ExpenseTracker extends StatefulWidget{
//   const ExpenseTracker({super.key});
//   @override
//   State<StatefulWidget> createState() => _ExpenseTrackerState();
//
// }
//
// class _ExpenseTrackerState extends State<ExpenseTracker>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(30,20,30,20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Good Morning",
//                             style: TextStyle(
//                               color: Colors.grey.shade400,
//                               fontSize: 20
//                             ),
//                           ),
//                           const SizedBox(height: 22,),
//                           const Text(
//                               "August 2026",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 38,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           )
//                         ],
//                       ),
//
//                       //notification
//                       Container(
//                         height: 64,
//                         width: 64,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF00351F),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             const Icon(Icons.notifications_outlined, color: Color(0xFF00E676)),
//                             Positioned(
//                               top: 8,
//                               right: 8,
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: const BoxDecoration(
//                                   color: Color(0xFF00E676),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Text(
//                                   '7',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF0A1C12),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Color(0xFF143321))
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('This Month', style: TextStyle(color: Colors.grey, fontSize: 14)),
//                             SizedBox(height: 8),
//                             Text(
//                               '₹1040',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text('of ₹50000 budget', style: TextStyle(color: Colors.grey, fontSize: 12),),
//                             SizedBox(height: 16,),
//                             Text('REMAINING',style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 0.5)),
//                             SizedBox(height: 4,),
//                             Text('₹48960', style: TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 22),),
//
//                           ],
//                         ),
//                         Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             SizedBox(
//                               height: 80,
//                               width: 80,
//                               child: CircularProgressIndicator(
//
//                               ),
//                             )
//
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//       ),
//     );
//   }
// }
//
//
//
//
//
// import 'package:flutter/material.dart';
//
// class AppColors {
//   // Background & Surface
//   static const Color background = Color(0xFFF8F9FE);
//   static const Color white = Color(0xFFFFFFFF);
//
//   // Primary Accents
//   static const Color primary = Color(0xFF4A3AFF);
//   static const Color primaryLight = Color(0xFF8675FF);
//   static const Color primaryDark = Color(0xFF5E4BFF);
//
//   // Income & Expense Colors
//   static const Color incomeBg = Color(0xFFE8F7F0);
//   static const Color incomeText = Color(0xFF28A745);
//   static const Color expenseBg = Color(0xFFFCEAEA);
//   static const Color expenseText = Color(0xFFDC3545);
//
//   // Text Colors
//   static const Color textMain = Color(0xFF1E1E1E);
//   static const Color textMuted = Color(0xFF757575);
//
//   // Category Chart Colors
//   static const Color catHome = Color(0xFF4A3AFF);
//   static const Color catFood = Color(0xFFFFB74D);
//   static const Color catTransport = Color(0xFF29B6F6);
//   static const Color catEducation = Color(0xFFFF8A65);
//   static const Color catOthers = Color(0xFF66BB6A);
// }
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Chart mate
// import '../utils/app_colors.dart';
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
// class _HomeScreenState extends State<HomeScreen> {
//   // UI mate Dummy Categories Data
//   final List<CategoryModel> categories = [
//     CategoryModel(name: "Home", percentage: "35%", color: AppColors.catHome),
//     CategoryModel(name: "Food", percentage: "25%", color: AppColors.catFood),
//     CategoryModel(name: "Transport", percentage: "15%", color: AppColors.catTransport),
//     CategoryModel(name: "Education", percentage: "15%", color: AppColors.catEducation),
//     CategoryModel(name: "Others", percentage: "10%", color: AppColors.catOthers),
//   ];
//
//   // UI mate Dummy Transactions
//   final List<TransactionModel> recentTransactions = [
//     TransactionModel(
//       title: "Grocery Shopping",
//       date: DateTime.now(), // Real app ma proper date hase
//       amount: 1250.00,
//       iconPath: "🛒",
//       category: "Food",
//     ),
//     TransactionModel(
//       title: "Electricity Bill",
//       date: DateTime.now().subtract(const Duration(days: 1)),
//       amount: 1800.00,
//       iconPath: "⚡",
//       category: "Home",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
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
//               const SizedBox(height: 30), // Bottom scroll space
//             ],
//           ),
//         ),
//       ),
//
//       // Center Floating Button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add Expense code pachi aavshe
//         },
//         backgroundColor: AppColors.primary,
//         shape: const CircleBorder(),
//         elevation: 4,
//         child: const Icon(Icons.add, color: AppColors.white, size: 32),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//       // Bottom Navigation Bar
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
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textMain,
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               "Here's your family overview",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textMuted,
//               ),
//             ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF000000).withOpacity(0.05),
//                 blurRadius: 10,
//                 spreadRadius: 1,
//               )
//             ],
//           ),
//           child: const Icon(Icons.tune, color: AppColors.textMain),
//         ),
//       ],
//     );
//   }
//
//   // 2. Total Balance Card
//   Widget _buildBalanceCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryDark, AppColors.primaryLight],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primary.withOpacity(0.4),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
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
//                 style: TextStyle(
//                   color: Color(0xFFE0E0E0), // Light grey text
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "₹ 45,230.50",
//                 style: TextStyle(
//                   color: AppColors.white,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: AppColors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: const [
//                     Icon(Icons.arrow_upward, color: Color(0xFF4CAF50), size: 14), // Green Accent
//                     SizedBox(width: 4),
//                     Text(
//                       "12.5% vs last month",
//                       style: TextStyle(color: AppColors.white, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // Background Wallet Icon
//           Positioned(
//             right: -10,
//             top: 10,
//             child: Icon(
//               Icons.account_balance_wallet,
//               color: AppColors.white.withOpacity(0.15),
//               size: 80,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 3. This Month Summary
//   Widget _buildMonthSummary() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "This Month Summary",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _summaryCard("Income", "₹ 72,450", AppColors.incomeBg, AppColors.incomeText),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               child: _summaryCard("Expense", "₹ 27,219", AppColors.expenseBg, AppColors.expenseText),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _summaryCard(String title, String amount, Color bgColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             amount,
//             style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 4. Spending Overview (fl_chart)
//   Widget _buildSpendingOverview() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Spending Overview",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF000000).withOpacity(0.02),
//                 blurRadius: 10,
//                 spreadRadius: 2,
//               )
//             ],
//           ),
//           child: Row(
//             children: [
//               // Fl_Chart Donut Chart
//               SizedBox(
//                 width: 130,
//                 height: 130,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     PieChart(
//                       PieChartData(
//                         sectionsSpace: 2,
//                         centerSpaceRadius: 45,
//                         sections: categories.map((cat) {
//                           return PieChartSectionData(
//                             color: cat.color,
//                             value: double.parse(cat.percentage.replaceAll('%', '')),
//                             title: '', // Text hide karva
//                             radius: 12,
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Text(
//                           "₹ 27,219",
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textMain),
//                         ),
//                         Text(
//                           "Total",
//                           style: TextStyle(color: AppColors.textMuted, fontSize: 11),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 24),
//
//               // Custom Legend
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: categories.map((cat) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 10.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(backgroundColor: cat.color, radius: 5),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               cat.name,
//                               style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
//                             ),
//                           ),
//                           Text(
//                             cat.percentage,
//                             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textMain),
//                           ),
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
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Text(
//               "Recent Transactions",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
//             ),
//             Icon(Icons.more_horiz, color: AppColors.textMuted),
//           ],
//         ),
//         const SizedBox(height: 16),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: recentTransactions.length,
//           itemBuilder: (context, index) {
//             final tx = recentTransactions[index];
//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF000000).withOpacity(0.02),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   )
//                 ],
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.incomeBg, // Change based on category in real app
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(tx.iconPath, style: const TextStyle(fontSize: 22)),
//                 ),
//                 title: Text(
//                   tx.title,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textMain),
//                 ),
//                 subtitle: const Text(
//                   "Today, 08:30 AM", // Real app ma date format use karishu
//                   style: TextStyle(color: AppColors.textMuted, fontSize: 12),
//                 ),
//                 trailing: Text(
//                   "₹ ${tx.amount.toStringAsFixed(0)}",
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textMain),
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
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF000000).withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 10.0,
//         color: AppColors.white,
//         elevation: 0,
//         child: SizedBox(
//           height: 65,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildNavItem(Icons.home_filled, "Home", true),
//               _buildNavItem(Icons.list_alt, "Transactions", false),
//               const SizedBox(width: 48), // FAB mate vachhe jagya
//               _buildNavItem(Icons.account_balance_wallet_outlined, "Budget", false),
//               _buildNavItem(Icons.more_horiz, "More", false),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String label, bool isActive) {
//     return MaterialButton(
//       minWidth: 40,
//       onPressed: () {},
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: isActive ? AppColors.primary : AppColors.textMuted,
//             size: 26,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 10,
//               color: isActive ? AppColors.primary : AppColors.textMuted,
//               fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
