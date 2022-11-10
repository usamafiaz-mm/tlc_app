import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/db/DbHandler.dart';
import 'package:tlc_app/models/form_data_model.dart';
import 'package:tlc_app/screens/form_screen.dart';
import 'package:tlc_app/utils/constants.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({Key? key}) : super(key: key);
  static const routeName = "/monitoring-screen";

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DBHandler.getMonitoringData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            print(snapshot.data?.length);
            // if (snapshot.data!.isEmpty) return Text("No data");
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                final temp = FormDataModel.fromJson(snapshot.data![index]);
                final map = jsonDecode(temp.formValue!);
                // print("ss" + map["page_0"]);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white70,
                    subtitle: Text("Date Created :" +
                        DateFormat("dd-MM-yyyy").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                temp.creationDate!))),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        final temp =
                            FormDataModel.fromJson(snapshot.data![index]);
                        final map = jsonDecode(temp.formValue!);
                        final array =
                            FormInstance.form.control("page_4") as FormArray;
                        final list = map["page_4"] as List;
                        array.clear();
                        for (int i = 0; i < list.length; i++) {
                          final ctrl = FormGroup({
                            "class": FormControl<int>(),
                            "boys": FormControl<int>(),
                            "girls": FormControl<int>(),
                            "total": FormControl<int>(),
                          });
                          ctrl.patchValue(list[i]);
                          array.add(ctrl);
                        }
                        map.remove("page_4");
                        final array_temp =
                            FormInstance.form.control("page_5") as FormArray;
                        final list_temp = map["page_5"] as List;
                        array_temp.clear();
                        for (int i = 0; i < list_temp.length; i++) {
                          final ctrl = FormGroup({
                            "class": FormControl<int>(),
                            "boys_sci": FormControl<int>(),
                            "boys_art": FormControl<int>(),
                            "girls_sci": FormControl<int>(),
                            "girls_art": FormControl<int>(),
                          });
                          ctrl.patchValue(list_temp[i]);
                          array_temp.add(ctrl);
                        }
                        map.remove("page_5");

                        FormInstance.form.patchValue(map);
                        return FormScreen(
                          id: snapshot.data![index]["id"],
                        );
                      })).then((value) {
                        setState(() {});
                        FormInstance.form.reset();
                      });
                    },
                    title: Text(
                      "EMIS CODE : " + map["page_0"]["emis_code"].toString(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(FormScreen.routeName).then((value) {
            setState(() {});
            FormInstance.form.reset(removeFocus: true);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
