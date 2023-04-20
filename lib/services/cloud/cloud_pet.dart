import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/cloud/cloud_storage_const.dart';

@immutable
class CloudPet {
  final String documentId;
  final String ownerUserId;
  final String petName;
  final String petType;
  final String petDescription;
  final String petAge;
  const CloudPet({
    required this.documentId,
    required this.ownerUserId,
    required this.petName,
    required this.petType,
    required this.petDescription,
    required this.petAge,
  });

  CloudPet.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerIdField] as String? ?? '',
        petName = snapshot.data()[petNameField] as String? ?? '',
        petType = snapshot.data()[petTypeField] as String? ?? '',
        petDescription = snapshot.data()[petDescriptionField] as String? ?? '',
        petAge = snapshot.data()[petAgeField] as String? ?? '0';
}
