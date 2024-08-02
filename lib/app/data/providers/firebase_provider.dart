import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseProvider {
  final CollectionReference locationCollectionDragonfly =
      FirebaseFirestore.instance.collection('wc');
  final CollectionReference locationCollectionCompactor =
      FirebaseFirestore.instance.collection('cp');
  final CollectionReference locationCollectionPruning =
      FirebaseFirestore.instance.collection('pr');

  final CollectionReference locationCollectionRs =
      FirebaseFirestore.instance.collection('sc');
  final CollectionReference locationCollectionMs =
      FirebaseFirestore.instance.collection('ms');

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
}