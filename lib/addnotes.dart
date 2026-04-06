import 'package:flutter/material.dart';
import 'package:sql_flite/home.dart';
import 'package:sql_flite/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 50, 149, 195),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.title, color: Colors.blue, size: 22),
                  ),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: TextFormField(
                  controller: note,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.edit_note,
                      color: Colors.green,
                      size: 22,
                    ),
                    alignLabelWithHint: true,
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: TextFormField(
                  controller: color,
                  decoration: InputDecoration(
                    hintText: 'Color',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: Colors.orange,
                      size: 22,
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              width: 50,
              child: MaterialButton(
                onPressed: () async {
                  int reponse = await sqlDb.insertData('''
                  INSERT INTO notes (note,title,color) 
                  values ("${note.text}","${title.text}","${color.text}")
                ''');
                  if (reponse > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false,
                    );
                  }
                  print(
                    "reponse===================================================",
                  );
                },
                minWidth: 120,
                height: 52,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                color: const Color.fromARGB(196, 255, 255, 255),
                textColor: Color.fromARGB(255, 50, 149, 195),
                child: Text(
                  'Add Note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
