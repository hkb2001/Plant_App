import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class HeartMain extends StatefulWidget {
  const HeartMain({Key? key}) : super(key: key);

  @override
  State<HeartMain> createState() => _HeartMainState();
}

class _HeartMainState extends State<HeartMain> {
  final database = FirebaseDatabase.instance.ref('todos');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          ShowDialog(context);
        },
        child: Container(
            height: 50,
            width: 45,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryColor.withOpacity(0.4),
                      blurRadius: 40,
                      spreadRadius: 4)
                ]),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: database.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SizedBox(
                          height: 40,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          )));
                } else {
                  Map m = snapshot.data!.snapshot.value as Map;
                  List<dynamic> lis = m.values.toList();
                  return ListView.builder(
                    itemCount: lis.length,
                    itemBuilder: (context, index) {
                      return Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          elevation: 2,
                          shadowColor: kPrimaryColor.withOpacity(0.7),
                          surfaceTintColor: kPrimaryColor,
                          margin: const EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lis[index]['title'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(),
                                    PersonAttrib(
                                        title: lis[index]['descrp'],
                                        icon: Icons.note),
                                  ],
                                ),
                                PopupMenuButton(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  color: Colors.grey,
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          child: ListTile(
                                        onTap: () {
                                          ShowDialog(context,
                                              id: lis[index]['id']);
                                        },
                                        title: const Text('Edit'),
                                        leading: const Icon(Icons.edit,
                                            color: kPrimaryColor),
                                      )),
                                      PopupMenuItem(
                                          child: ListTile(
                                        onTap: () {
                                          database
                                              .child(lis[index]['id'])
                                              .remove();
                                        },
                                        title: const Text('Delete'),
                                        leading: const Icon(
                                            Icons.delete_forever,
                                            color: kPrimaryColor),
                                      ))
                                    ];
                                  },
                                )
                              ],
                            ),
                          ));
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<void> ShowDialog(BuildContext context, {String id = ''}) async {
    final database = FirebaseDatabase.instance.ref('todos');
    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    String modalTitle = 'Add Todo';
    if (id != '') {
      DataSnapshot snapshot = await database.child(id).get();
      Map m = snapshot.value as Map;
      name.text = m['title'];
      email.text = m['descrp'];
      modalTitle = 'Update Todo';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 2,
          icon: Icon(
              id == '' ? Icons.person_add_alt_1_rounded : Icons.person_rounded,
              size: 50),
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20))),
          title: Center(
              child: Text(
            modalTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          content: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          hintText: "type here...",
                        ),
                      ),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "type here...",
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (id == '') {
                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      database.child(id).set({
                        'id': id,
                        'title': name.text.toString().trim(),
                        'descrp': email.text.toString().trim(),
                      });
                      Navigator.pop(context);
                    } else {
                      database.child(id).update({
                        'title': name.text.toString().trim(),
                        'descrp': email.text.toString().trim(),
                      });
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Save'))
          ],
        );
      },
    );
  }
}

class PersonAttrib extends StatelessWidget {
  const PersonAttrib({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }
}
