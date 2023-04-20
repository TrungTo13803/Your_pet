class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreatePetException implements CloudStorageException {}

class CouldNotGetAllPetsException implements CloudStorageException {}

class CouldNotUpdatePetException implements CloudStorageException {}

class CouldNotDeletePetException implements CloudStorageException {}
