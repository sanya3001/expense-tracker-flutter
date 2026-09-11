import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/family_member_model.dart';
import '../../providers/family_provider.dart';
import '../../utils/app_colors.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  const AddFamilyMemberScreen({super.key});

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedRole = "Member";

  final List<String> _roles = ["Admin", "Member", "Child", "Spouse", "Parent"];

  void _saveMember() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter member name")));
      return;
    }

    final newMember = FamilyMemberModel(name: _nameController.text.trim(), email: _emailController.text.trim(), role: _selectedRole, createdAt: DateTime.now());

    await Provider.of<FamilyProvider>(context, listen: false).addMember(newMember);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String initialLetter = _nameController.text.trim().isNotEmpty ? _nameController.text.trim()[0].toUpperCase() : "?";

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white, elevation: 0, centerTitle: true, leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.textMain, size: 20), onPressed: () => Navigator.pop(context)), title: const Text("Add Family Member", style: TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Avatar with auto initial letter
            CircleAvatar(radius: 45, backgroundColor: const Color(0xFFEDE7F6), child: Text(initialLetter, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.primary))),
            const SizedBox(height: 35),

            // 1. Name Field
            _buildInputField(controller: _nameController, hintText: "Full Name", icon: Icons.person_outline, onChanged: (val) => setState(() {})),
            const SizedBox(height: 20),

            // 2. Email Field
            _buildInputField(controller: _emailController, hintText: "Email (Optional)", icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),

            // 3. Role Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE0E0E0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRole,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
                  items:
                      _roles.map((role) {
                        return DropdownMenuItem(value: role, child: Row(children: [const Icon(Icons.badge_outlined, color: AppColors.textMuted, size: 22), const SizedBox(width: 12), Text(role, style: const TextStyle(color: AppColors.textMain, fontSize: 15))]));
                      }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedRole = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Add Member Button
            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: _saveMember, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0), child: const Text("Add Member", style: TextStyle(fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String hintText, required IconData icon, TextInputType keyboardType = TextInputType.text, Function(String)? onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE0E0E0))),
      child: TextField(controller: controller, keyboardType: keyboardType, onChanged: onChanged, style: const TextStyle(fontSize: 15, color: AppColors.textMain), decoration: InputDecoration(icon: Icon(icon, color: AppColors.textMuted, size: 22), hintText: hintText, hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 15), border: InputBorder.none)),
    );
  }
}
