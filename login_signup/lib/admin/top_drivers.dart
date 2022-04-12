import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/admin/report.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart' if (dart.library.html) 'web.dart';
import 'dart:io';

class TopDrivers extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  TopDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Top Drivers",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.print),
          onPressed: _createPDF          
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('driver_ratings')
            // .orderBy('driverID')
            .where('avgRating', isGreaterThan: "4.4")
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

                  return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/driveravatar.png",
                        width: 60.0,
                      ),
                      title: Column(
                        children: [
                          Text("Driver ID: " + document['driverID'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(height: 1.5)),
                          Text("Average Rating: " + document['avgRating'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(height: 1.5)),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  Future<void> _createPDF() async {
    final querySnapshot = await FirebaseFirestore.instance
                // .collection('drivers')
                // .orderBy('driverEmail')
                // .get();
                .collection('driver_ratings')
                .where('avgRating', isGreaterThan: "4.4")
                .get();
            PdfDocument pdfdocument = PdfDocument();
            // final driverList = fetchData();
            final page = pdfdocument.pages.add();
            page.graphics.drawString('Top Drivers Report',
                PdfStandardFont(PdfFontFamily.helvetica, 30));

            page.graphics.drawImage(
                PdfBitmap(await _readImageData('matatu_splash0.png')),
                const Rect.fromLTWH(50, 100, 300, 300));

            PdfGrid grid = PdfGrid();
            grid.style = PdfGridStyle(
                font: PdfStandardFont(PdfFontFamily.helvetica, 20),
                cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

            grid.columns.add(count: 2);
            grid.headers.add(1);

            PdfGridRow header = grid.headers[0];
            header.cells[0].value = 'Driver ID';
            header.cells[1].value = 'Rating';
            // header.cells[2].value = 'Email';

            for (var doc in querySnapshot.docs) {
              PdfGridRow row = grid.rows.add();

              // DriverModel docList = driverList[i];
              row.cells[0].value = doc.get('driverID');
              row.cells[1].value = doc.get('avgRating');
              // row.cells[2].value = doc.get('driverEmail');
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
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('./assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
