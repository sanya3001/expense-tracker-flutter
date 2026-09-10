import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/family_member_model.dart';

class FamilyProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<FamilyMemberModel> _members = [];

  FamilyProvider() {
    fetchFamilyMembers();
  }

  List<FamilyMemberModel> get members => _members;

  // Real-time listener from Firestore
  void fetchFamilyMembers() {
    _firestore
        .collection('family_members')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((snapshot) {
      _members = snapshot.docs
          .map((doc) => FamilyMemberModel.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    });
  }

  Future<void> addMember(FamilyMemberModel member) async {
    try {
      await _firestore.collection('family_members').add(member.toMap());
    } catch (e) {
      debugPrint("Error adding member: $e");
    }
  }
}