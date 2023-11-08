import 'package:add_list_view/models/incometile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController firstnameFieldController;
  late TextEditingController surnameFieldController;
  late TextEditingController incomeFieldController;

  @override
  void initState() {
    firstnameFieldController = TextEditingController();
    surnameFieldController = TextEditingController();
    incomeFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstnameFieldController.dispose();
    surnameFieldController.dispose();
    incomeFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        leading: Icon(Icons.abc),
        title: const Text("Home"),
        actions: const [
          Icon(Icons.add),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.red,
        child: Icon(Icons.home),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Income logger",
                    style: TextStyle(fontSize: 30, color: Colors.white)),
              ],
            ),

            // TextField(
            //   style: const TextStyle(fontSize: 16, color: Colors.white),
            //   decoration: InputDecoration(
            //     contentPadding: const EdgeInsets.symmetric(vertical: 12),
            //     hintText: "Search Employee....",
            //     hintStyle: const TextStyle(color: Colors.grey),
            //     prefixIcon: const Icon(
            //       Icons.search,
            //       color: Colors.grey,
            //     ),
            //     fillColor: Colors.grey.shade800,
            //     filled: true,
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //       borderSide: BorderSide(color: Colors.grey.shade400),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(color: Colors.transparent),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: employeeRecord.length,
                  itemBuilder: (context, index) {
                    final record = employeeRecord[index];
                    //check if list is empty or not
                    return employeeRecord.isEmpty
                        ? Container(
                            color: Colors.red,
                            height: 200,
                            width: 200,
                            child: const Text("Empty"),
                          )
                        : Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 2.0, color: Colors.white24),
                                    ),
                                  ),
                                  //list id
                                  child: Text(
                                    "${record.id + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                //employee full name
                                title: Text(
                                  record.fullname,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),

                                //employee income
                                subtitle: Row(
                                  children: [
                                    Text("K ${record.income}",
                                        style: const TextStyle(
                                            color: Colors.white))
                                  ],
                                ),
                                // trailing: const Icon(Icons.keyboard_arrow_right,
                                //     color: Colors.white, size: 30.0),
                              ),
                            ),
                          );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        child: FloatingActionButton.large(
          onPressed: () async {
            final result = await _alertDialog(context);

            //add record if result is not null!
            if (result != null) {
              setState(() {
                employeeRecord.add(
                  Details(
                    id: employeeRecord.length,
                    fullname: result[0] + " " + result[1],
                    income: result[2],
                    modifiedTime: DateTime.now(),
                  ),
                );
                firstnameFieldController.clear();
                surnameFieldController.clear();
                incomeFieldController.clear();
              });
            }
          },
          elevation: 10,
          shape: const CircleBorder(),
          backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
          child: const Icon(
            Icons.add,
            color: Colors.blue,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<dynamic> _alertDialog(BuildContext context) {
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: double.infinity, // Make the AlertDialog full width
              constraints: const BoxConstraints(
                maxHeight: 400.0,
              ), // Set a maximum height
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Add Employee"),
                  TextField(
                    controller: firstnameFieldController,
                    decoration: InputDecoration(
                      label: const Text("Name"),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: surnameFieldController,
                    decoration: InputDecoration(
                      label: const Text("Surname"),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: incomeFieldController,
                    decoration: InputDecoration(
                      labelText: "Income",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //get input from the text fields ? maybe?
                      TextButton(
                        onPressed: () {
                          final result = validateInput(firstnameFieldController,
                              surnameFieldController, incomeFieldController);
                          //if the result != null, there's something atleast
                          if (result) {
                            Navigator.pop(
                              context,
                              [
                                firstnameFieldController.text,
                                surnameFieldController.text,
                                incomeFieldController.text,
                              ],
                            );
                          } else {}
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool validateInput(firstname, surname, income) {
    if (firstname.text == "" || surname.text == "" || income.text == "") {
      return false;
    }
    return true;
  }
}
