import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../providers/expense_provider.dart';
import '../../models/transaction_model.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  bool _isExpense = true; // Toggle mate: true = Expense, false = Income
  String _selectedCategory = "Food";
  DateTime _selectedDate = DateTime.now();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Design pramane Category no data (Icons ane Colors sathe)
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Food', 'icon': '🍔', 'bgColor': const Color(0xFFFCEAEA), 'iconColor': Colors.redAccent},
    {'name': 'Home', 'icon': '🏠', 'bgColor': const Color(0xFFE8F5E9), 'iconColor': Colors.green},
    {'name': 'Transport', 'icon': '🚗', 'bgColor': const Color(0xFFE3F2FD), 'iconColor': Colors.blue},
    {'name': 'Education', 'icon': '📚', 'bgColor': const Color(0xFFFFF3E0), 'iconColor': Colors.orange},
    {'name': 'Health', 'icon': '💊', 'bgColor': const Color(0xFFFCE4EC), 'iconColor': Colors.pink},
    {'name': 'Shopping', 'icon': '🛍️', 'bgColor': const Color(0xFFF3E5F5), 'iconColor': Colors.purple},
    {'name': 'Bills', 'icon': '🧾', 'bgColor': const Color(0xFFE0F7FA), 'iconColor': Colors.cyan},
    {'name': 'Others', 'icon': '📦', 'bgColor': const Color(0xFFFFFDE7), 'iconColor': Colors.amber},
  ];

  // Date select karva mate
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.primary, onPrimary: Colors.white, onSurface: AppColors.textMain)), child: child!);
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Data Save karva mate
  void _saveTransaction() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter amount")));
      return;
    }

    final double amount = double.parse(_amountController.text);

    // Select kareli category mathi icon find karvo
    final selectedCatData = _categories.firstWhere((cat) => cat['name'] == _selectedCategory);
    final transaction = TransactionModel(title: _notesController.text.isNotEmpty ? _notesController.text : _selectedCategory, date: _selectedDate, amount: amount, iconPath: selectedCatData['icon'], isIncome: !_isExpense, category: _selectedCategory);
    // Provider ma data add karvo
    Provider.of<ExpenseProvider>(context, listen: false).addTransaction(transaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.textMain, size: 20), onPressed: () => Navigator.pop(context)),
        title: const Text("Add Expense", style: TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.ios_share, color: AppColors.primary, size: 22), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Toggle Button (Expense / Income)
            _buildToggleButton(),
            const SizedBox(height: 30),

            // 2. Categories Grid
            Wrap(spacing: 20, runSpacing: 20, alignment: WrapAlignment.spaceBetween, children: _categories.map((cat) => _buildCategoryItem(cat)).toList()),
            const SizedBox(height: 30),

            // 3. Amount Field
            const Text("Amount", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textMain)),
            const SizedBox(height: 8),
            _buildTextField(controller: _amountController, hintText: "0.00", prefixText: "₹ ", keyboardType: TextInputType.number),
            const SizedBox(height: 20),

            // 4. Date Picker Field
            const Text("Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textMain)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0E0E0)), borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(DateFormat('dd MMM yyyy').format(_selectedDate), style: const TextStyle(fontSize: 15, color: AppColors.textMain)), const Icon(Icons.calendar_today_outlined, color: AppColors.textMuted, size: 20)]),
              ),
            ),
            const SizedBox(height: 20),

            // 5. Notes Field
            const Text("Notes (Optional)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textMain)),
            const SizedBox(height: 8),
            _buildTextField(controller: _notesController, hintText: "Write a note"),
            const SizedBox(height: 40),

            // 6. Save Button
            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: _saveTransaction, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0), child: const Text("Save Expense", style: TextStyle(fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: const Color(0xFFF4F5F7), borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpense = true),
              child: Container(
                decoration: BoxDecoration(color: _isExpense ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(25), boxShadow: _isExpense ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : []),
                alignment: Alignment.center,
                child: Text("Expense", style: TextStyle(color: _isExpense ? AppColors.white : AppColors.textMuted, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpense = false),
              child: Container(
                decoration: BoxDecoration(color: !_isExpense ? AppColors.white : Colors.transparent, borderRadius: BorderRadius.circular(25), boxShadow: !_isExpense ? [const BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 4))] : []),
                alignment: Alignment.center,
                child: Text("Income", style: TextStyle(color: !_isExpense ? AppColors.primary : AppColors.textMuted, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> cat) {
    bool isSelected = _selectedCategory == cat['name'];
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = cat['name']),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 60, height: 60, decoration: BoxDecoration(color: cat['bgColor'], shape: BoxShape.circle, border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null), alignment: Alignment.center, child: Text(cat['icon'], style: const TextStyle(fontSize: 24))),
          const SizedBox(height: 8),
          Text(cat['name'], style: TextStyle(fontSize: 12, color: isSelected ? AppColors.primary : AppColors.textMain, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // Text Field Custom
  Widget _buildTextField({required TextEditingController controller, required String hintText, String? prefixText, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE0E0E0))),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15, color: AppColors.textMain, fontWeight: FontWeight.w600),
        decoration: InputDecoration(hintText: hintText, hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.normal), prefixText: prefixText, prefixStyle: const TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.bold), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
      ),
    );
  }
}
