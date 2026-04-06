import 'package:flutter/material.dart';
import 'package:sql_flite/editenotes.dart';
import 'package:sql_flite/sqldb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future<void> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotesAPP'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 50, 149, 195),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView(
                children: [
                  // MaterialButton(
                  //   onPressed: () async {
                  //     await sqlDb.mydeleteDatabase();
                  //     notes.clear();
                  //     isLoading = true;
                  //     setState(() {});
                  //     await readData();
                  //   },
                  //   child: Text('delete database'),
                  // ),
                  ListView.builder(
                    itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text("${notes[i]['title']}"),
                            subtitle: Text("${notes[i]['note']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    int response = await sqlDb.deleteData(
                                      'DELETE FROM notes WHERE id = ${notes[i]['id']}',
                                    );
                                    if (response > 0) {
                                      setState(() {
                                        notes.removeWhere(
                                          (element) =>
                                              element['id'] == notes[i]['id'],
                                        );
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditNotes(
                                          color: notes[i]["color"],
                                          title: notes[i]["title"],
                                          note: notes[i]["note"],
                                          id: notes[i]["id"],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
