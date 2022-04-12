import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../designs/theme_helper.dart';
import 'package:flutter/services.dart';
import 'mobile.dart' if (dart.library.html) 'web.dart';

class Report extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Top Drivers Report",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.print),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Report()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('drivers')
            // .where('avgRating', isGreaterThan: "4.4")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];

                  if (document.id == auth.currentUser!.uid) {
                    return Container(height: 0);
                  }

                  return Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            'Generate Report'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        onPressed: () async {
                          PdfDocument pdfdocument = PdfDocument();
                          // final driverList = fetchData();
                          final page = pdfdocument.pages.add();
                          page.graphics.drawString('Top Drivers Report',
                              PdfStandardFont(PdfFontFamily.helvetica, 30));

                          page.graphics.drawImage(
                              PdfBitmap(
                                  await _readImageData('matatu_splash0.png')),
                              const Rect.fromLTWH(0, 10, 100, 100));

                          PdfGrid grid = PdfGrid();
                          grid.style = PdfGridStyle(
                              font:
                                  PdfStandardFont(PdfFontFamily.helvetica, 20),
                              cellPadding: PdfPaddings(
                                  left: 5, right: 2, top: 2, bottom: 2));

                          grid.columns.add(count: 3);
                          grid.headers.add(1);

                          PdfGridRow header = grid.headers[0];
                          header.cells[0].value = 'firstName';
                          header.cells[1].value = 'secondName';
                          header.cells[2].value = 'Email';

                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            PdfGridRow row = grid.rows.add();

                            // DriverModel docList = driverList[i];
                            row.cells[0].value = document['firstName'];
                            row.cells[1].value = document['secondName'];
                            row.cells[2].value = document['driverEmail'];
                          }

                          // row = grid.rows.add();
                          // row.cells[0].value = document['firstName'];
                          // row.cells[1].value = document['secondName'];
                          // row.cells[2].value = document['driverEmail'];

                          // row = grid.rows.add();
                          // row.cells[0].value = document['firstName'];
                          // row.cells[1].value = document['secondName'];
                          // row.cells[2].value = document['driverEmail'];

                          grid.draw(
                              page: pdfdocument.pages.add(),
                              bounds: const Rect.fromLTWH(0, 0, 0, 0));

                          List<int> bytes = pdfdocument.save();
                          pdfdocument.dispose();

                          saveAndLaunchFile(bytes, 'Report.pdf');

                          // final pdf = pw.Document();

                          // pdf.addPage(
                          //   pw.Page(
                          //     build: (pw.Context context) => pw.Center(
                          //       child: pw.Text("Driver ID: " + document['driverID'],
                          //     ),
                          //   ),
                          // ));

                          // final file = File('Report.pdf');
                          // await file.writeAsBytes(await pdf.save());
                        }),
                  );

                  // return Card(
                  //   elevation: 10,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15.0),
                  //   ),
                  //   child: ListTile(
                  //     leading: Image.asset(
                  //       "assets/images/driveravatar.png",
                  //       width: 60.0,
                  //     ),
                  //     title: Column(
                  //       children: [
                  //         Text("Driver ID: " + document['driverID'],
                  //             textAlign: TextAlign.center,
                  //             style: const TextStyle(height: 1.5)),
                  //         Text("Average Rating: " + document['avgRating'],
                  //             textAlign: TextAlign.center,
                  //             style: const TextStyle(height: 1.5)),
                  //       ],
                  //     ),
                  //   ),
                  // );
                });
          }
        },
      ),
    );
  }

  // List<DriverModel> fetchData() {
  //   final db = FirebaseFirestore.instance;
  //   List<DriverModel> driverList = <DriverModel>[];
  //   db.collection("drivers").get().then((snapshot) {
  //     for (var document in snapshot.docs) {
  //       driverList.add(DriverModel(
  //           driverID: document['driverID'],
  //           driverEmail: document['driverEmail'],
  //           driverfirstName: document['firstName'],
  //           driversecondName: document['secondName'],
  //           avgRating: document['avgRating']));
  //     }
  //   });
  //   return driverList;
  // }

  // final Stream<QuerySnapshot<Map<String, dynamic>>> result =
  //       FirebaseFirestore.instance.collection('submits').snapshots();
  // final List<DocumentSnapshot> documents = result.documents;

  // List<String> myListString = []; // My list I want to create.

  // documents.forEach((snapshot) {
  //   myListString.add(snapshot.documentID)
  // });

  // List<User> userList = [
  //   User(name: "a", email: "a"),
  //   User(name: "d", email: "b"),
  //   User(name: "c", email: "c"),
  // ];

  // Future<void> _createPDF() async {
  // PdfDocument document = PdfDocument();

  // final page = document.pages.add();
  // page.graphics.drawString('Welcome to PDF Succinctly!',
  //     PdfStandardFont(PdfFontFamily.helvetica, 30));

  // page.graphics.drawImage(PdfBitmap(await _readImageData('logo.png')),
  //     const Rect.fromLTWH(0, 10, 100, 100));

  // PdfGrid grid = PdfGrid();
  // grid.style = PdfGridStyle(
  //     font: PdfStandardFont(PdfFontFamily.helvetica, 30),
  //     cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

  // grid.columns.add(count: 3);
  // grid.headers.add(1);

  // PdfGridRow header = grid.headers[0];
  // header.cells[0].value = 'Roll No';
  // header.cells[1].value = 'Name';
  // header.cells[2].value = 'Class';

  // PdfGridRow row = grid.rows.add();
  // row.cells[0].value = '1';
  // row.cells[1].value = 'Arya';
  // row.cells[2].value = '6';

  // row = grid.rows.add();
  // row.cells[0].value = '2';
  // row.cells[1].value = 'John';
  // row.cells[2].value = '9';

  // row = grid.rows.add();
  // row.cells[0].value = '3';
  // row.cells[1].value = 'Tony';
  // row.cells[2].value = '8';

  // grid.draw(
  //     page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

  // List<int> bytes = document.save();
  // document.dispose();

  // saveAndLaunchFile(bytes, 'Output.pdf');
  // }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('./assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
