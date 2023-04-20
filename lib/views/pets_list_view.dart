import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';
import 'package:demo/utilities/dialogs/delete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllPetsListView extends StatefulWidget {
  const AllPetsListView({Key? key}) : super(key: key);

  @override
  State<AllPetsListView> createState() => _AllPetsListViewState();
}

class _AllPetsListViewState extends State<AllPetsListView> {
  late final FirebaseCloudStorage _appService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                homeRoute, (route) => false);
                          },
                          icon: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Color(0xFF0f67ca),
                          ))),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text(
                        'Your pets',
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )))
                ],
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: FittedBox(
                            child: Text(
                              'Recently added',
                              style: TextStyle(
                                  color: Color(0xff212121),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: _appService.allPets(ownerUserId: userId),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.active:
                                    if (snapshot.hasData) {
                                      final allPets =
                                          snapshot.data as Iterable<CloudPet>;
                                      return PetsListView(
                                        pet: allPets,
                                        onDeletePet: (pet) async {
                                          await _appService.deletePet(
                                              documentId: pet.documentId);
                                        },
                                        onTap: (pet) {
                                          Navigator.of(context).pushNamed(
                                            createOrUpdatePetRoute,
                                            arguments: pet,
                                          );
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive());
                                    }
                                  default:
                                    return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

typedef PetCallback = void Function(CloudPet pet);

class PetsListView extends StatelessWidget {
  final Iterable<CloudPet> pet;
  final PetCallback onDeletePet;
  final PetCallback onTap;

  const PetsListView({
    Key? key,
    required this.pet,
    required this.onDeletePet,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pet.length,
      itemBuilder: (context, index) {
        final text = pet.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(text);
          },
          title: Text(
            text.petName,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeletePet(text);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
