import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/cloud/cloud_note.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/cloud_schedule.dart';
import 'package:demo/services/cloud/cloud_storage_const.dart';
import 'package:demo/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final pets = FirebaseFirestore.instance.collection('pets');
  final schedules = FirebaseFirestore.instance.collection('schedule');
  final notes = FirebaseFirestore.instance.collection('notes');

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePetException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String petName,
    required String noteTitle,
    required String note,
  }) async {
    try {
      await notes.doc(documentId).update({
        petNameField: petName,
        noteTitleField: noteTitle,
        noteField: note,
      });
    } catch (e) {
      throw CouldNotUpdatePetException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) {
    return notes.snapshots().map((event) => event.docs
        .map((doc) => CloudNote.fromSnapshot(doc))
        .where((note) => note.ownerUserId == ownerUserId));
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(
            ownerIdField,
            isEqualTo: ownerUserId,
          )
          .get()
          .then(
              (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    } catch (e) {
      throw CouldNotGetAllPetsException();
    }
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerIdField: ownerUserId,
      petNameField: '',
      noteTitleField: '',
      noteField: '',
    });

    final fetchNote = await document.get();
    return CloudNote(
      documentId: fetchNote.id,
      ownerUserId: ownerUserId,
      petName: '',
      noteTitle: '',
      note: '',
    );
  }

  Future<void> deletePet({required String documentId}) async {
    try {
      await pets.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePetException();
    }
  }

  Future<void> updatePet({
    required String documentId,
    required String petName,
    required String petType,
    required String petDescription,
    required String petAge,
    required String petDisease,
    required String lastTimeSick,
    required String weight,
  }) async {
    try {
      await pets.doc(documentId).update({
        petNameField: petName,
        petTypeField: petType,
        petDescriptionField: petDescription,
        petAgeField: petAge,
        petDiseaseField: petDisease,
        lastTimeSickField: lastTimeSick,
        weightField: weight,
      });
    } catch (e) {
      throw CouldNotUpdatePetException();
    }
  }

  Stream<Iterable<CloudPet>> allPets({required String ownerUserId}) {
    return pets.snapshots().map((event) => event.docs
        .map((doc) => CloudPet.fromSnapshot(doc))
        .where((pet) => pet.ownerUserId == ownerUserId));
  }

  Future<Iterable<CloudPet>> getPets({required String ownerUserId}) async {
    try {
      return await pets
          .where(
            ownerIdField,
            isEqualTo: ownerUserId,
          )
          .get()
          .then((value) => value.docs.map((doc) => CloudPet.fromSnapshot(doc)));
    } catch (e) {
      throw CouldNotGetAllPetsException();
    }
  }

  Future<CloudPet> createNewPet({required String ownerUserId}) async {
    final document = await pets.add({
      ownerIdField: ownerUserId,
      petNameField: '',
      petTypeField: '',
      petDescriptionField: '',
      petAgeField: '0',
      petDiseaseField: '',
      lastTimeSickField: '',
      weightField: '0',
    });

    final fetchPet = await document.get();
    return CloudPet(
      documentId: fetchPet.id,
      ownerUserId: ownerUserId,
      petName: '',
      petType: '',
      petDescription: '',
      petAge: '0',
      petDisease: '',
      lastTimeSick: '',
      weight: '0',
    );
  }

  Future<void> deleteSchedule({required String documentId}) async {
    try {
      await schedules.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePetException();
    }
  }

  Future<void> updateSchedule({
    required String documentId,
    required String activityTitle,
    required String activityDescription,
    required String activityTime,
    required String activityDate,
    required String petName,
  }) async {
    try {
      await schedules.doc(documentId).update({
        activityTitleField: activityTitle,
        activityDescriptionField: activityDescription,
        activityTimeField: activityTime,
        activityDateField: activityDate,
        petNameField: petName,
      });
    } catch (e) {
      throw CouldNotUpdatePetException();
    }
  }

  Stream<Iterable<CloudSchedule>> allSchedules({required String ownerUserId}) {
    return schedules.snapshots().map((event) => event.docs
        .map((doc) => CloudSchedule.fromSnapshot(doc))
        .where((schedule) => schedule.ownerUserId == ownerUserId));
  }

  Future<Iterable<CloudSchedule>> getSchedule(
      {required String ownerUserId}) async {
    try {
      return await schedules
          .where(
            ownerIdField,
            isEqualTo: ownerUserId,
          )
          .get()
          .then((value) =>
              value.docs.map((doc) => CloudSchedule.fromSnapshot(doc)));
    } catch (e) {
      throw CouldNotGetAllPetsException();
    }
  }

  Future<CloudSchedule> createNewSchedule({required String ownerUserId}) async {
    final document = await schedules.add({
      ownerIdField: ownerUserId,
      activityTitleField: '',
      activityDescriptionField: '',
      activityTimeField: '',
      activityDateField: '',
      petNameField: '',
    });

    final fetchSchedule = await document.get();
    return CloudSchedule(
      documentId: fetchSchedule.id,
      ownerUserId: ownerUserId,
      activityTitle: '',
      activityDescription: '',
      activityTime: '',
      activityDate: '',
      petName: '',
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
