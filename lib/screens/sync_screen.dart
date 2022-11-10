import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/db/DbHandler.dart';
import 'package:tlc_app/models/form_data_model.dart';

import '../utils/constants.dart';
import 'form_screen.dart';

class SyncScreen extends StatefulWidget {
  SyncScreen({Key? key}) : super(key: key);
  static const routeName = "/monitoring-screen";

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBHandler.getSyncData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Scaffold(
            body: ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                final temp = FormDataModel.fromJson(snapshot.data![index]);
                final map = jsonDecode(temp.formValue!);
                // print("ss" + map["page_0"]);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ListTile(
                        tileColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            final temp =
                                FormDataModel.fromJson(snapshot.data![index]);
                            final map = jsonDecode(temp.formValue!);
                            final array = FormInstance.form.control("page_4")
                                as FormArray;
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
                            final array_temp = FormInstance.form
                                .control("page_5") as FormArray;
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
                            FormInstance.form.markAsDisabled();

                            FormInstance.form.patchValue(map);
                            return FormScreen(
                              id: snapshot.data![index]["id"],
                              readOnly: true,
                            );
                          })).then((value) {
                            FormInstance.form.reset();
                            FormInstance.form.markAsEnabled();
                          });
                        },
                        title: Text(
                          "EMIS CODE :" + map["page_0"]["emis_code"].toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date Created :" +
                                DateFormat("dd-MM-yyyy hh:mm aa").format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        temp.creationDate!))),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Date Ended :" +
                                DateFormat("dd-MM-yyyy hh:mm aa").format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        temp.endingDate!))),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4)),
                          child: ColoredBox(
                            color: Colors.green.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Not Synced",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            persistentFooterButtons: [
              Visibility(
                visible: snapshot.data != null && snapshot.data!.length > 0,
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Sync"))),
                  ],
                ),
              )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
