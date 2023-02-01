import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Display"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('user').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData != null) {
                  return ListView.builder(
                      itemCount:
                          snapshot.hasData ? snapshot.data!.docs.length : 0,
                      reverse: false,
                      shrinkWrap: true,
                      primary: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: x['active'] == true && x['Experience'] >5
                                  ? Colors.green
                                  : Colors.red,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(x['name']),
                                  Text(x['active'] == true
                                      ? "Active Employee"
                                      : "Unactive Employee"),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      )),
    );
  }
}
