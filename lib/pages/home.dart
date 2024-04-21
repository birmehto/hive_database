import 'package:database/boxses/boxes.dart';
import 'package:database/method/data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titlecontroller = TextEditingController();
  final discriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hive'),
        ),
        body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, child) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: IconButton(
                        onPressed: () {
                          editdata(data[index], data[index].title,
                              data[index].discription);
                        },
                        icon: const Icon(Icons.edit)),
                    title: Text(data[index].title.toString()),
                    subtitle: Text(data[index].discription.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        delete(data[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            myDailog();
          },
          child: const Icon(Icons.add),
        ));
  }

  Future<void> myDailog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: discriptioncontroller,
                  decoration: InputDecoration(
                      hintText: 'Discription',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            const SizedBox(
              width: 5,
            ),
            TextButton(
                onPressed: () {
                  final data = NotesModel(
                      title: titlecontroller.text,
                      discription: discriptioncontroller.text);
                  final box = Boxes.getData();
                  box.add(data);
                  data.save();
                  // print(box);
                  titlecontroller.clear();
                  discriptioncontroller.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        );
      },
    );
  }

  Future<void> editdata(
      NotesModel notesModel, String title, String discription) async {
    titlecontroller.text = title;
    discriptioncontroller.text = discription;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: discriptioncontroller,
                  decoration: InputDecoration(
                      hintText: 'Discription',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            const SizedBox(
              width: 5,
            ),
            TextButton(
                onPressed: () async {
                  notesModel.title = titlecontroller.text;
                  notesModel.discription = discriptioncontroller.text;
                  notesModel.save();
                  titlecontroller.clear();
                  discriptioncontroller.clear();
                  Navigator.pop(context);
                },
                child: const Text('Edit')),
          ],
        );
      },
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }
}
