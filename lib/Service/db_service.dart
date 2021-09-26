import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DbHelper {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Notes');

  User? user = FirebaseAuth.instance.currentUser;

//Add todo
  Future<String> add({String? title, String? body}) async {
    try {
      String formatedDate = DateFormat.jm().format(DateTime.now());
      final data = {
        'title': title,
        'body': body,
        'time': formatedDate,
      };

      await dbCollection.doc(user!.uid).collection('MyNotes').add(data);

      return 'Note Added';
    } catch (e) {
      return e.toString();
    }
  }

//update
  Future<String> update({String? id, String? title, String? body}) async {
    try {
      String formatedDate = DateFormat.jm().format(DateTime.now());
      final data = {
        'title': title,
        'body': body,
        'time': formatedDate,
      };

      dbCollection.doc(user!.uid).collection('MyNotes').doc(id).update(data);

      return 'Note Updated';
    } catch (e) {
      return e.toString();
    }
  }

  ///delete
  Future<String> delete({String? id, String? title, String? body}) async {
    try {
      dbCollection.doc(user!.uid).collection('MyNotes').doc(id).delete();

      return 'Note Deleted';
    } catch (e) {
      return e.toString();
    }
  }
}
