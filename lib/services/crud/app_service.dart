import 'package:demo/services/crud/crud_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class AppService {
  Database? _db;

  Future<DatabasePets> updatePet(
      {required DatabasePets pet, required String name}) async {
    final db = _getDatabaseOrThrow();
    await getPet(id: pet.id);

    final result = await db.update(petsTable, {
      nameColumn: name,
    });

    if (result == 0) {
      throw CouldNotUpdatePet();
    } else {
      return await getPet(id: pet.id);
    }
  }

  Future<Iterable<DatabasePets>> getAllPets() async {
    final db = _getDatabaseOrThrow();
    final pets = await db.query(
      petsTable,
    );

    return pets.map((petRow) => DatabasePets.fromRow(petRow));
  }

  Future<DatabasePets> getPet({required int id}) async {
    final db = _getDatabaseOrThrow();
    final pet = await db.query(
      petsTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (pet.isEmpty) {
      throw CouldNotFindPet();
    } else {
      return DatabasePets.fromRow(pet.first);
    }
  }

  Future<int> deleteAllPets() async {
    final db = _getDatabaseOrThrow();
    return await db.delete(petsTable);
  }

  Future<void> deletePet({required int id}) async {
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      petsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (deletedCount == 0) {
      throw CouldNotDeletePet();
    }
  }

  Future<DatabasePets> createPet({required DatabaseUser owner}) async {
    final db = _getDatabaseOrThrow();
    final dbUser = await getUser(email: owner.email);
    if (db != owner) {
      throw CouldNotFindUser();
    }

    const name = '';
    // create pet
    final petId = await db.insert(petsTable, {
      userIdColumn: owner.id,
      nameColumn: name,
    });

    final pet = DatabasePets(
      id: petId,
      userId: owner.id,
      name: name,
    );

    return pet;
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (deletedCount != 1) {
      throw CouldNotDeleteUser();
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final result = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (result.isNotEmpty) {
      throw UserAlreadyExists();
    }

    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });

    return DatabaseUser(
      id: userId,
      email: email,
    );
  }

  Future<DatabaseUser> getUser({required String email}) async {
    final db = _getDatabaseOrThrow();

    final result = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (result.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DatabaseUser.fromRow(result.first);
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      await db.execute(createUserTable);

      await db.execute(createPetsTable);
    } on MissingPlatformDirectoryException {
      throw UnableToOpenGetDocumentsDirectory();
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;
  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() {
    return 'User, id: $id, email: $email';
  }

  @override
  bool operator ==(covariant DatabaseUser other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

class DatabasePets {
  final int id;
  final int userId;
  final String name;
  const DatabasePets({
    required this.id,
    required this.userId,
    required this.name,
  });

  DatabasePets.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        name = map[nameColumn] as String;

  @override
  String toString() => 'Pet, id: $id, userId: $userId, name: $name';

  @override
  bool operator ==(covariant DatabaseUser other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

const dbName = 'app.db';
const petsTable = 'pets';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'userId';
const nameColumn = 'name';
const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
	      "id"	INTEGER NOT NULL,
	      "email"	TEXT NOT NULL UNIQUE,
	      PRIMARY KEY("id" AUTOINCREMENT)
        );''';
const createPetsTable = '''CREATE TABLE IF NOT EXISTS "pets" (
	      "id"	INTEGER NOT NULL,
	      "user_id"	INTEGER NOT NULL,
	      "name"	TEXT,
	      FOREIGN KEY("user_id") REFERENCES "user"("id"),
	      PRIMARY KEY("id" AUTOINCREMENT)
        );''';
