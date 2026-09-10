import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/family_provider.dart';
import '../../utils/app_colors.dart';


class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  Color _getAvatarColor(String text) {
    final colors = [
      const Color(0xFFFFEBEE),
      const Color(0xFFE8F5E9),
      const Color(0xFFE3F2FD),
      const Color(0xFFFFF3E0),
      const Color(0xFFF3E5F5),
      const Color(0xFFE0F7FA),
    ];
    return colors[text.codeUnitAt(0) % colors.length];
  }

  Color _getTextColor(String text) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];
    return colors[text.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final familyProvider = Provider.of<FamilyProvider>(context);
    final members = familyProvider.members;

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
          "Family Members",
          style: TextStyle(
            color: AppColors.textMain,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FamilyScreen()),
              );
            },
          )
        ],
      ),
      body: members.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No family members added yet",
                style: TextStyle(color: AppColors.textMuted, fontSize: 15)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FamilyScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Invite Member", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          final initial = member.name.isNotEmpty ? member.name[0].toUpperCase() : "?";

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: _getAvatarColor(member.name),
                child: Text(
                  initial,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(member.name),
                  ),
                ),
              ),
              title: Text(
                member.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.textMain,
                ),
              ),
              subtitle: Text(
                member.role,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
              trailing: member.role.toLowerCase() == "admin"
                  ? const Text("👑", style: TextStyle(fontSize: 16))
                  : null,
            ),
          );
        },
      ),
    );
  }
}
