import 'package:belajar_dasar_individu/models/todo.dart';
import 'package:belajar_dasar_individu/todo_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String _activity = '';

  //yang dibawah seperi state() di React
  // final TextEditingController _activityUser = TextEditingController();

  //Global key
  final _formKey = GlobalKey<FormState>();

  PrioritySet _selectedPriority = PrioritySet.low;

  String _title = '';
  String _description = '';

  final List<TodoModel> todos = [
    const TodoModel(
        title: 'Buy Milk',
        description: 'Buy 1 liter of milk',
        priority: PrioritySet.high),
    const TodoModel(
        title: 'Belajar Flutter',
        description: 'Minimal buat satu page',
        priority: PrioritySet.urgent),
  ];

  @override
  Widget build(BuildContext context) {
    // debugPrint('Todos: $todos');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Flutter'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TodoListClass(todosData: todos),
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What do you want?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            // TextField(
            //   onChanged: (value) => setState(
            //     () => _activity = value,
            //   ),
            //   keyboardType: TextInputType.text,
            //   decoration: const InputDecoration(
            //     label: Text('What do you want to do?'),
            //   ),
            // ),

            // FORM and Button ------------------------------------------------------------------
            // TextField(
            //   controller: _activityUser,
            //   keyboardType: TextInputType.text,
            //   decoration: const InputDecoration(
            //     label: Text('What do you want?'),
            //   ),
            // ),

            Form(
              //Key digunakan untuk memvalidasi, menyimpan data,
              // dapat diakses, dan bahkan untuk setting bahwa form tak boleh dikosongkan
              key: _formKey,
              child: Column(
                children: [
                  //To do Title
                  TextFormField(
                    maxLength: 20,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // Cek kalo form kosong maka ....
                        return 'Title tidak boleh kosong!';
                      }
                      //null = berarti lolos dalam validasi
                      return null;
                    },
                    //OnSaved berfungsi untuk menyimpan data ketika form di submit (Jika validasi sudah berhasil, maka fungsi ini baru dipanggil dan akan menyimpan data)
                    onSaved: (value) => {
                      _title = value!,
                    },

                    //OnChanged berfungsi untuk memantau perubahan data
                    onChanged: (value) => {
                      setState(() {
                        _title = value;
                        debugPrint('Title ------------------- : $_title');
                      }),
                    },
                  ),

                  // To do Description
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 5) {
                        return 'Setidaknya 5 karakter!';
                      }
                      return null;
                    },
                    onSaved: (value) => {
                      _description = value!,
                    },
                    onChanged: (value) => {
                      setState(() {
                        _description = value;
                        debugPrint(
                            'Description ------------------- : $_description');
                      }),
                    },
                  ),

                  // Priority
                  DropdownButtonFormField(
                    value: _selectedPriority,
                    decoration:
                        const InputDecoration(label: Text('Priority of todo')),
                    items: PrioritySet.values.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value!;
                        //CekPriority() cuman buat debugging ajaa!
                        debugPrint(
                            'Priority ------------------- : $_selectedPriority');
                      });
                    },
                  ),

                  // Submit Button
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        // Untuk memvalidasi form
                        if (_formKey.currentState!.validate()) {
                          //.save() digunakan untuk menyimpan data yang ada di form input masing2 ke dalam variable
                          _formKey.currentState!.save();

                          setState(() {
                            todos.add(TodoModel(
                              title: _title,
                              description: _description,
                              priority: _selectedPriority,
                            ));
                          });

                          //Mereset atau menghapus data yang ada di form ketika disubmit
                          _formKey.currentState!.reset();
                          _selectedPriority = PrioritySet.low;

                          //Menghilangkan keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 58, 53, 53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
