import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/cloud/cloud_storage_const.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String noteTitle;
  final String petName;
  final String note;
  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.noteTitle,
    required this.petName,
    required this.note,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerIdField] as String? ?? '',
        noteTitle = snapshot.data()[noteTitleField] as String? ?? '',
        petName = snapshot.data()[petNameField] as String? ?? '',
        note = snapshot.data()[noteField] as String? ?? '';
}
