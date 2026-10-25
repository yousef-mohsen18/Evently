import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_task/model/fire_store/User.dart';
import 'package:evently_task/model/fire_store/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';

class FireStoreManager {
  static CollectionReference<User> getUserCollection() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data();
            return User.formFireStore(data);
          },
          toFirestore: (value, options) {
            return value.toFireStore();
          },
        );

    return collection;
  }

  static Future<void> saveUser(User myUser) {
    var collection = getUserCollection();
    var doc = collection.doc(myUser.id);
    return doc.set(myUser);
  }

  static Future<User?> getUserData() async {
    var collection = getUserCollection();
    var doc = collection.doc(auth.FirebaseAuth.instance.currentUser?.uid);
    var snapshot = await doc.get();
    return snapshot.data();
  }

  static CollectionReference<EventModel> getEventCollection() {
    var collection = FirebaseFirestore.instance
        .collection("Event")
        .withConverter(
          fromFirestore: (snapshot, options) {
            var data = snapshot.data();
            return EventModel.fromFireStore(data);
          },
          toFirestore: (value, options) {
            return value.toFireStore();
          },
        );

    return collection;
  }

  static Future<void> saveEvent(EventModel event) {
    var collection = getEventCollection();
    var doc = collection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Stream<List<EventModel>> listenALlEvents() async* {
    var collection = getEventCollection();
    var queryDocsSnapshotStream = collection.snapshots();
    var docsStream = queryDocsSnapshotStream.map(
      (docSnapShot) => docSnapShot.docs,
    );
    var eventStream = docsStream.map(
      (docs) => docs.map((document) => document.data()).toList(),
    );
    yield* eventStream;
  }

  static Future<List<EventModel>> getFilterEvents(String type) async {
    var collection = getEventCollection().where("type", isEqualTo: type);
    var queryDocsSnapshot = await collection.get();
    var docs = queryDocsSnapshot.docs;
    List<EventModel> events = docs.map((document) => document.data()).toList();
    return events;
  }

  static CollectionReference<EventModel> getFavCollection() {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(auth.FirebaseAuth.instance.currentUser?.uid);
    var collection = doc
        .collection("Event Favorite")
        .withConverter(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data();
            return EventModel.fromFireStore(data);
          },
          toFirestore: (value, options) {
            return value.toFireStore();
          },
        );

    return collection;
  }

  static Future<void> addEventFavorite(EventModel event) {
    var favoriteCollection = getFavCollection();
    var doc = favoriteCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<void> deleteEventFavorite(EventModel event) {
    var favoriteCollection = getFavCollection();
    var doc = favoriteCollection.doc(event.id );
    return doc.delete();
  }

  static Future<void> updateUser(List<String> favorite) {
    var collection = getUserCollection();
    var doc = collection.doc(auth.FirebaseAuth.instance.currentUser?.uid);
    return doc.update({"favorites": favorite});
  }

  static Stream<List<EventModel>> listenFavorite() async* {
    var collection = getFavCollection();
    var queryDocsSnapshotStream = collection.snapshots();
    var docsStream = queryDocsSnapshotStream.map(
          (docSnapShot) => docSnapShot.docs,
    );
    var eventStream = docsStream.map(
          (docs) => docs.map((document) => document.data()).toList(),
    );
    yield* eventStream;
  }
}
