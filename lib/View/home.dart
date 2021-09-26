import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/Service/auth_service.dart';
import 'package:firebase_todo_app/Service/db_service.dart';
import 'package:firebase_todo_app/View/view_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'auth_view.dart';
import 'create_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Notes');

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note app"),
        actions: [
          IconButton(
              onPressed: () {
                AuthClass().logout().then((value) {
                  if (value == 'Sign out') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GoogleAuthPage()),
                        (route) => false);
                  }
                });
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dbCollection.doc(user!.uid).collection('MyNotes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No note added yet !"),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs.map((data) {
                    String title = data.get('title');
                    final time = data.get('time');
                    String body = data.get('body');

                    String id = data.id;

                    return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewNote(
                                title: title,
                                body: body,
                                id : id,
                              ),
                            ),
                          );
                        },
                        title: Text(title),
                        subtitle: Text("$time"),
                        trailing: IconButton(
                            onPressed: () {
                              DbHelper().delete(id: id).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              });
                            },
                            icon: const Icon(Icons.delete)),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!),
                        ));
                  }),
                  const SizedBox(
                    height: 80,
                  )
                ],
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateNotePage()),
            );
          },
          label: Row(
            children: const [Icon(Icons.add), Text("Add note")],
          )),
    );
  }
}
