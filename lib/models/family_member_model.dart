import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyMemberModel {
  final String? id;
  final String name;
  final String email;
  final String role;
  final DateTime createdAt;

  FamilyMemberModel({
    this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory FamilyMemberModel.fromMap(Map<String, dynamic> map, String docId) {
    return FamilyMemberModel(
      id: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'Member',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
