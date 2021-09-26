import 'package:firebase_todo_app/Service/db_service.dart';
import 'package:flutter/material.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    ///Title note
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                        label: Text('Note title'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title is empty';
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    ///Description
                    ///
                    TextFormField(
                        controller: body,
                        maxLines: 8,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'body is empty';
                          }
                        },
                        decoration: const InputDecoration(
                            label: Text('Note body'),
                            border: OutlineInputBorder()))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (key.currentState!.validate()) {
              ///Save dat to firebase
              DbHelper()
                  .add(title: title.text.trim(), body: body.text.trim())
                  .then((value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(value)));
              });
            }
          },
          label: Row(
            children: const [Icon(Icons.add), Text("Save note")],
          )),
    );
  }
}
