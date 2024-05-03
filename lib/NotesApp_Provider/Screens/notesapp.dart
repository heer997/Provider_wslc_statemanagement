import "dart:ffi";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:provider_wslc_statemanagement/NotesApp_Provider/Screens/adddatascreen.dart";
import "package:provider_wslc_statemanagement/NotesApp_Provider/providers/noteProvider.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return NotesProvider();
      },
      child: MaterialApp(
        title: "NotesApp using Provider",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const NotesApp(),
      ),
    );
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() {
    return NotesAppState();
  }
}

class NotesAppState extends State<NotesApp> {
  deleteNotes(int noteid) {
    context.read<NotesProvider>().delete(noteid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes App using Provider",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.getNotes().length,
            itemBuilder: (context, index) {
              var currentdata = value.getNotes()[index];
              return Card(
                child: ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  title: Text(
                    currentdata.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(currentdata.desc),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Delete data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Text("Are you sure ?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  deleteNotes(currentdata.id!.toInt());
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddDataScreen();
              },
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
    );
  }
}
