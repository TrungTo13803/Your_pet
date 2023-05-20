import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/cloud/cloud_storage_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@immutable
class CloudSchedule {
  final String documentId;
  final String ownerUserId;
  final String activityTitle;
  final String activityDescription;
  final String activityTime;
  final String activityDate;
  final String petName;

  const CloudSchedule({
    required this.documentId,
    required this.ownerUserId,
    required this.activityTitle,
    required this.activityDescription,
    required this.activityTime,
    required this.activityDate,
    required this.petName,
  });

  CloudSchedule.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerIdField] as String? ?? '',
        activityTitle = snapshot.data()[activityTitleField] as String? ?? '',
        activityDescription =
            snapshot.data()[activityDescriptionField] as String? ?? '',
        activityTime = snapshot.data()[activityTimeField] as String? ?? '',
        activityDate = snapshot.data()[activityDateField] as String? ?? '',
        petName = snapshot.data()[petNameField] as String? ?? '';
}
