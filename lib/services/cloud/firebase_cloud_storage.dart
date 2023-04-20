import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/cloud_storage_const.dart';
import 'package:demo/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final pets = FirebaseFirestore.instance.collection('pets');

  Future<void> deletePet({required String documentId}) async {
    try {
      await pets.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePetException();
    }
  }

  Future<void> updatePet(
      {required String documentId,
      required String petName,
      required String petType,
      required String petDescription,
      required String petAge}) async {
    try {
      await pets.doc(documentId).update({
        petNameField: petName,
        petTypeField: petType,
        petDescriptionField: petDescription,
        petAgeField: petAge
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
    });

    final fetchPet = await document.get();
    return CloudPet(
      documentId: fetchPet.id,
      ownerUserId: ownerUserId,
      petName: '',
      petType: '',
      petDescription: '',
      petAge: '0',
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
