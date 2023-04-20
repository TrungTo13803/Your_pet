// import 'dart:async';

// import 'package:demo/services/crud/crud_exceptions.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' show join;

// class AppService {
//   Database? _db;

//   List<DatabasePets> _pets = [];

//   static final AppService _shared = AppService._sharedInstance();
//   AppService._sharedInstance() {
//     _petsStreamController = StreamController<List<DatabasePets>>.broadcast(
//         onListen: () => _petsStreamController.sink.add(_pets));
//   }

//   factory AppService() => _shared;

//   late final StreamController<List<DatabasePets>> _petsStreamController;

//   Stream<List<DatabasePets>> get allPets => _petsStreamController.stream;

//   Future<DatabaseUser> getOrCreateUser({required String email}) async {
//     try {
//       final user = await getUser(email: email);
//       return user;
//     } on CouldNotFindUser {
//       final createdUser = await createUser(email: email);
//       return createdUser;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> _cachePets() async {
//     final allPets = await getAllPets();
//     _pets = allPets.toList();
//     _petsStreamController.add(_pets);
//   }

//   Future<DatabasePets> updatePet(
//       {required DatabasePets pet, required String name}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     await getPet(id: pet.id);

//     final result = await db.update(petsTable, {
//       nameColumn: name,
//     });

//     if (result == 0) {
//       throw CouldNotUpdatePet();
//     } else {
//       final updatedPet = await getPet(id: pet.id);
//       _pets.removeWhere((pet) => pet.id == updatedPet.id);
//       _pets.add(updatedPet);
//       _petsStreamController.add(_pets);
//       return updatedPet;
//     }
//   }

//   Future<Iterable<DatabasePets>> getAllPets() async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final pets = await db.query(
//       petsTable,
//     );

//     return pets.map((petRow) => DatabasePets.fromRow(petRow));
//   }

//   Future<DatabasePets> getPet({required int id}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final pets = await db.query(
//       petsTable,
//       limit: 1,
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     if (pets.isEmpty) {
//       throw CouldNotFindPet();
//     } else {
//       final pet = DatabasePets.fromRow(pets.first);
//       _pets.removeWhere((pet) => pet.id == id);
//       _pets.add(pet);
//       _petsStreamController.add(_pets);
//       return pet;
//     }
//   }

//   Future<int> deleteAllPets() async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final numberOfDeletions = await db.delete(petsTable);
//     _pets = [];
//     _petsStreamController.add(_pets);
//     return numberOfDeletions;
//   }

//   Future<void> deletePet({required int id}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final deletedCount = await db.delete(
//       petsTable,
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     if (deletedCount == 0) {
//       throw CouldNotDeletePet();
//     } else {
//       _pets.removeWhere((pet) => pet.id == id);
//       _petsStreamController.add(_pets);
//     }
//   }

//   Future<DatabasePets> createPet({required DatabaseUser owner}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final dbUser = await getUser(email: owner.email);
//     if (db != owner) {
//       throw CouldNotFindUser();
//     }

//     const name = '';
//     // create pet
//     final petId = await db.insert(petsTable, {
//       userIdColumn: owner.id,
//       nameColumn: name,
//     });

//     final pet = DatabasePets(
//       id: petId,
//       userId: owner.id,
//       name: name,
//     );

//     _pets.add(pet);
//     _petsStreamController.add(_pets);

//     return pet;
//   }

//   Future<void> deleteUser({required String email}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final deletedCount = await db.delete(
//       userTable,
//       where: 'email = ?',
//       whereArgs: [email.toLowerCase()],
//     );

//     if (deletedCount != 1) {
//       throw CouldNotDeleteUser();
//     }
//   }

//   Future<DatabaseUser> createUser({required String email}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();
//     final result = await db.query(
//       userTable,
//       limit: 1,
//       where: 'email = ?',
//       whereArgs: [email.toLowerCase()],
//     );

//     if (result.isNotEmpty) {
//       throw UserAlreadyExists();
//     }

//     final userId = await db.insert(userTable, {
//       emailColumn: email.toLowerCase(),
//     });

//     return DatabaseUser(
//       id: userId,
//       email: email,
//     );
//   }

//   Future<DatabaseUser> getUser({required String email}) async {
//     await _ensureDbIsOpen();
//     final db = _getDatabaseOrThrow();

//     final result = await db.query(
//       userTable,
//       limit: 1,
//       where: 'email = ?',
//       whereArgs: [email.toLowerCase()],
//     );

//     if (result.isEmpty) {
//       throw CouldNotFindUser();
//     } else {
//       return DatabaseUser.fromRow(result.first);
//     }
//   }

//   Database _getDatabaseOrThrow() {
//     final db = _db;
//     if (db == null) {
//       throw DatabaseIsNotOpen();
//     } else {
//       return db;
//     }
//   }

//   Future<void> close() async {
//     final db = _db;
//     if (db == null) {
//       throw DatabaseIsNotOpen();
//     } else {
//       await db.close();
//       _db = null;
//     }
//   }

//   Future<void> open() async {
//     if (_db != null) {
//       throw DatabaseAlreadyOpenException();
//     }
//     try {
//       final docsPath = await getApplicationDocumentsDirectory();
//       final dbPath = join(docsPath.path, dbName);
//       final db = await openDatabase(dbPath);
//       _db = db;

//       await db.execute(createUserTable);

//       await db.execute(createPetsTable);

//       await _cachePets();
//     } on MissingPlatformDirectoryException {
//       throw UnableToOpenGetDocumentsDirectory();
//     }
//   }

//   Future<void> _ensureDbIsOpen() async {
//     try {
//       await open();
//     } on DatabaseAlreadyOpenException {}
//   }
// }

// @immutable
// class DatabaseUser {
//   final int id;
//   final String email;
//   const DatabaseUser({
//     required this.id,
//     required this.email,
//   });

//   DatabaseUser.fromRow(Map<String, Object?> map)
//       : id = map[idColumn] as int,
//         email = map[emailColumn] as String;

//   @override
//   String toString() {
//     return 'User, id: $id, email: $email';
//   }

//   @override
//   bool operator ==(covariant DatabaseUser other) {
//     return id == other.id;
//   }

//   @override
//   int get hashCode => id.hashCode;
// }

// class DatabasePets {
//   final int id;
//   final int userId;
//   final String name;

//   DatabasePets({
//     required this.id,
//     required this.userId,
//     required this.name,
//   });

//   DatabasePets.fromRow(Map<String, Object?> map)
//       : id = map[idColumn] as int,
//         userId = map[userIdColumn] as int,
//         name = map[nameColumn] as String;

//   @override
//   String toString() => 'Pet, id: $id, userId: $userId, name: $name';

//   @override
//   bool operator ==(covariant DatabaseUser other) {
//     return id == other.id;
//   }

//   @override
//   int get hashCode => id.hashCode;
// }

// const dbName = 'app.db';
// const petsTable = 'pets';
// const userTable = 'user';
// const idColumn = 'id';
// const emailColumn = 'email';
// const userIdColumn = 'userId';
// const nameColumn = 'name';
// const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
// 	      "id"	INTEGER NOT NULL,
// 	      "email"	TEXT NOT NULL UNIQUE,
// 	      PRIMARY KEY("id" AUTOINCREMENT)
//         );''';
// const createPetsTable = '''CREATE TABLE IF NOT EXISTS "pets" (
// 	      "id"	INTEGER NOT NULL,
// 	      "user_id"	INTEGER NOT NULL,
// 	      "name"	TEXT,
// 	      FOREIGN KEY("user_id") REFERENCES "user"("id"),
// 	      PRIMARY KEY("id" AUTOINCREMENT)
//         );''';
