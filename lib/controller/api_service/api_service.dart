import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  static Future<void> addToFirebase({
    required String collectionName,
    required Map<String, dynamic> body,
  }) async {
    try {
      // Reference to Firestore collection
      final collection = FirebaseFirestore.instance.collection(collectionName);

      // Generate a new document ID
      final docRef = collection.doc();
      final id = docRef.id;

      // Add the id field to the body
      body['id'] = id;

      // Add item to Firestore with the updated body
      await docRef.set(body);

      log('Data added successfully with ID: $id');
    } catch (e) {
      log('Error adding item: $e');
    }
  }

  static fetchDataFromFirebase({collectionName}) async {
    try {
      // Reference to Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);

      // Fetch documents from Firestore
      QuerySnapshot querySnapshot = await collection.get();

      return querySnapshot;
    } catch (e) {
      log('Error fetching collection from firebase: $e');
      return [];
    }
  }

  static Future<void> editCollectionDataInFirebase({
    required String categoryId,
    required String collectionName,
    body,
  }) async {
    try {
      // Reference to the Firestore document
      DocumentReference categoryDoc =
          FirebaseFirestore.instance.collection(collectionName).doc(categoryId);

      // Update the category in Firestore
      await categoryDoc.update(body);

      log('updated successfully');
    } catch (e) {
      log('Error updating : $e');
      throw Exception('Failed to update collection: $collectionName: $e');
    }
  }

  static Future<void> deleteFromFirebase({id, collectionName}) async {
    try {
      // Reference to Firestore collection
      final categoriesCollection =
          FirebaseFirestore.instance.collection(collectionName);

      // Delete the document by ID
      await categoriesCollection.doc(id).delete();

      log('data deleted successfully!');
    } catch (e) {
      log('Error deleting category: $e');
    }
  }
}
