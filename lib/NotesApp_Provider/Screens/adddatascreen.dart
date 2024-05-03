import "dart:developer";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:provider_wslc_statemanagement/NotesApp_Provider/Models/noteModel.dart";
import "package:provider_wslc_statemanagement/NotesApp_Provider/Utils/uihelper.dart";
import "package:provider_wslc_statemanagement/NotesApp_Provider/providers/noteProvider.dart";

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() {
    return AddDataScreenState();
  }
}

class AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Data Screen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UiHelper.customTextFormField(
              titleController,
              "Enter the title",
              Icons.title,
            ),
            UiHelper.customTextFormField(
              descController,
              "Enter the description",
              Icons.description,
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                addData(
                  titleController.text.toString(),
                  descController.text.toString(),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350.0, 50.0),
                backgroundColor: Colors.blue,
                shape: const LinearBorder(),
              ),
              child: const Text(
                "Add Data",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addData(String title, String desc) {
    if (title == "" || desc == "") {
      log("Enter Required Fields");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Enter Required Fields",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      context.read<NotesProvider>().addData(
            NotesModel(title: title, desc: desc),
          );
      log("Data Inserted Successfully...");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Data Inserted Successfully...",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      titleController.clear();
      descController.clear();
    }
  }
}
