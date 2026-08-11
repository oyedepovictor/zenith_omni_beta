import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Todoey extends StatefulWidget {
  const Todoey({super.key});

  @override
  State<Todoey> createState() => _TodoeyState();
}

class _TodoeyState extends State<Todoey> {
  final myBox = Hive.box('my_box');
  final textController = TextEditingController();

  List todos = [];
  @override
  void initState() {
    // load the data, if none exists then default to empty list
    todos = myBox.get('TODO_LIST') ?? [];
    super.initState();
  }

  //open new todo dialog box
  void openNewTodoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add text'),
        content: TextField(controller: textController),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: Text('Cancel'),
          ),

          // add button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              addTodo();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  // add new todo
  void addTodo() {
    String todo = textController.text;
    setState(() {
      todos.add([todo, false]);
      saveToDatabase();
      textController.clear();
    });
  }

  //delete todo
  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
      saveToDatabase();
    });
  }

  // save to the database using hive
  void saveToDatabase() {
    myBox.put('TODO_LIST', todos);
  }

  void editTodo(int index) {
    setState(() {
      todos[index][0] = textController.text;
      saveToDatabase();
      textController.clear();
    });
  }

  void openEditDialog(int index) {
    textController.text = todos[index][0];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: TextField(controller: textController),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: Text('Cancel'),
          ),

          // add button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              editTodo(index);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: scheme.primary,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'todoey',
              child: SvgPicture.asset(
                'assets/app_icons/icon_todoey.svg',
                height: 40,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'TODOEY',
              style: GoogleFonts.inter(
                textStyle: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  fontSize: 25,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNewTodoDialog();
        },
        backgroundColor: scheme.primary,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          //get each todo
          final task = todos[index];
          return ListTile(
            leading: Checkbox(
              value: task[1],
              onChanged: (value) {
                setState(() {
                  todos[index][1] = value!;
                  saveToDatabase();
                });
              },
            ),
            title: Text(
              task[0],
              style: GoogleFonts.aBeeZee(
                textStyle: textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  decoration: task[1] ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    openEditDialog(index);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteTodo(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
