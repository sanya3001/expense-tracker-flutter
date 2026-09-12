import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/family_member_model.dart';

class FamilyProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<FamilyMemberModel> _members = [];
  String? _familyId;

  FamilyProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        initFamily(user);
      } else {
        clearData();
      }
    });
  }

  List<FamilyMemberModel> get members => _members;
  String? get familyId => _familyId;

  // 1. familyId find karvi
  Future<void> initFamily(User user) async {
    try {
      final userEmail = (user.email ?? '').trim().toLowerCase();

      final inviteQuery = await _firestore
          .collection('family_members')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (inviteQuery.docs.isNotEmpty) {
        _familyId = inviteQuery.docs.first.data()['familyId'];
      } else {
        _familyId = user.uid;

        // check kare admin che k nai
        final adminExists = await _firestore
            .collection('family_members')
            .where('familyId', isEqualTo: _familyId)
            .where('role', isEqualTo: 'Admin')
            .limit(1)
            .get();

        if (adminExists.docs.isEmpty) {
          // admin ne first member add karvo
          await _firestore.collection('family_members').add({
            'name': user.displayName ?? (userEmail.isNotEmpty ? userEmail.split('@')[0] : 'Admin'),
            'email': userEmail,
            'role': 'Admin',
            'familyId': _familyId,
            'createdAt': Timestamp.now(),
          });
        }
      }
      fetchFamilyMembers();
    } catch (e) {
      debugPrint("Error initializing family: $e");
    }
  }

  // 2. potani j familyId ma members lavva
  void fetchFamilyMembers() {
    if (_familyId == null) {
      _members = [];
      notifyListeners();
      return;
    }

    _firestore
        .collection('family_members')
        .where('familyId', isEqualTo: _familyId) // Strict filter
        .snapshots()
        .listen((snapshot) {
      _members = snapshot.docs
          .map((doc) => FamilyMemberModel.fromMap(doc.data(), doc.id))
          .toList();

      _members.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      notifyListeners();
    }, onError: (error) {
      debugPrint("Firestore Stream Error: $error");
    });
  }

  Future<void> addMember(FamilyMemberModel member) async {
    final user = _auth.currentUser;
    if (_familyId == null && user != null) {
      await initFamily(user);
    }
    if (_familyId == null) return;
    try {
      final data = member.toMap();
      data['familyId'] = _familyId;
      data['email'] = member.email.trim().toLowerCase();
      await _firestore.collection('family_members').add(data);
      debugPrint("Member added successfully with familyId: $_familyId");
    } catch (e) {
      debugPrint("Error adding member: $e");
    }
  }

  void clearData() {
    _members = [];
    _familyId = null;
    notifyListeners();
  }
}