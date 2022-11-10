import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/db/DbHandler.dart';
import 'package:tlc_app/models/form_data_model.dart';
import 'package:tlc_app/screens/form_pages/census_information.dart';
import 'package:tlc_app/screens/form_pages/higher_school_enrollment_information.dart';
import 'package:tlc_app/screens/form_pages/image_section.dart';
import 'package:tlc_app/screens/form_pages/other_student_enrollment.dart';
import 'package:tlc_app/screens/form_pages/registration_information.dart';
import 'package:tlc_app/screens/form_pages/school_basic_facilities.dart';
import 'package:tlc_app/screens/form_pages/school_information.dart';
import 'package:tlc_app/screens/form_pages/staff_information.dart';
import 'package:tlc_app/utils/constants.dart';

import 'form_pages/school_enrollment_information.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class FormScreen extends StatefulWidget {
  FormScreen({Key? key, this.id, this.readOnly = false}) : super(key: key);
  static String routeName = "/form-screen";
  final bool readOnly;

  @override
  State<FormScreen> createState() => _FormScreenState();
  var id;
}

class _FormScreenState extends State<FormScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  late final Map<String, Widget> formPages;
  String selectTileName = "1. Census Information";

  @override
  void initState() {
    super.initState();
    formPages = <String, Widget>{
      "1. Census Information": CensusInformation(readOnly: widget.readOnly),
      "2. School Information": SchoolInformation(
        readOnly: widget.readOnly,
      ),
      "3. Registration Information": RegistrationInformation(
        readOnly: widget.readOnly,
      ),
      "4. School Basic Facilities": SchoolBasicFacilities(
        readOnly: widget.readOnly,
      ),
      "5. School Enrollment Information": SchoolEnrollmentInformation(
        readOnly: widget.readOnly,
      ),
      "6. School Enrollment Information": HigherSchoolEnrollment(
        readOnly: widget.readOnly,
      ),
      "7. Other Students Enrollment": OtherStudentEnrollment(
        readOnly: widget.readOnly,
      ),
      "8.Total no. of Staff Information": StaffInformation(
        readOnly: widget.readOnly,
      ),
      "9.Image Section": ImageSection(
        readOnly: widget.readOnly,
      )
    };
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Annual School Census"),
      ),
      body: ReactiveForm(
        formGroup: FormInstance.form,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PageView(
            onPageChanged: (index) {
              print(index);
              setState(() {
                currentPage = index;
              });
            },
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: formPages.values.toList(),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    if (currentPage == 0) {
                      Navigator.pop(context);
                    } else {
                      controller.previousPage(
                          duration: Duration(microseconds: 1),
                          curve: Curves.linearToEaseOut);
                    }
                  },
                  child: currentPage == 0
                      ? const Text("Exit")
                      : const Text("Previous")),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () async {
                    FormInstance.form
                        .control("page_${currentPage}")
                        .markAsTouched();
                    if (widget.readOnly &&
                        currentPage < formPages.keys.length - 1) {
                      controller.nextPage(
                          duration: Duration(microseconds: 100),
                          curve: Curves.bounceIn);
                      return;
                    } else if (widget.readOnly &&
                        currentPage == formPages.keys.length - 1) {
                      Navigator.pop(context);
                    } else {
                      if (currentPage < formPages.keys.length - 1) {
                        if (FormInstance.form
                            .control("page_${currentPage}")
                            .invalid) {
                          FormInstance.form
                              .control("page_${currentPage}")
                              .markAllAsTouched();
                          return;
                        }

                        if (widget.id != null) {
                          await DBHandler.updateFormData(
                              jsonEncode(FormInstance.form.value), widget.id);
                        } else {
                          final temp = FormDataModel(
                              formValue: jsonEncode(FormInstance.form.value));
                          widget.id = await DBHandler.insertFormData(temp);
                        }
                        controller.nextPage(
                            duration: Duration(microseconds: 1),
                            curve: Curves.linearToEaseOut);
                      } else {
                        if (FormInstance.form
                            .control("page_${currentPage}")
                            .invalid) {
                          FormInstance.form
                              .control("page_${currentPage}")
                              .markAllAsTouched();
                          FormInstance.form
                              .control("page_${currentPage}")
                              .updateValueAndValidity();
                          print("marking as touched");
                          print(FormInstance.form
                              .control("page_${currentPage}.latitude")
                              .touched);
                          return;
                        }
                        if (FormInstance.form.valid) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                  TextButton(
                                      onPressed: () async {
                                        await DBHandler.finalSubmission(
                                            jsonEncode(FormInstance.form.value),
                                            widget.id);

                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Yes"))
                                ],
                                title: Text("Do you Want to save data?"),
                              );
                            },
                          );
                        } else {
                          FormInstance.form.markAllAsTouched();

                          final errors = FormInstance.form.errors;
                          List<Map>? errorList = [];
                          errors.forEach((key, value) {
                            final temp = key.split('_');
                            final pageName =
                                temp[0] + (int.parse(temp[1]) + 1).toString();
                            final List nameOfErrors = [];
                            (value as Map).forEach((key, value) {
                              nameOfErrors.add(key);
                            });
                            errorList.add({
                              "pageName": pageName,
                              "fields": nameOfErrors,
                              "errorMessages": []
                            });
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Please fill all required fields"),
                                icon: Icon(Icons.error_outline),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...errorList.map((e) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              (e["pageName"] as String)
                                                  .capitalize(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            ...(e["fields"] as List).map((e) {
                                              return Text("*" +
                                                  (e as String)
                                                      .split("_")
                                                      .join(" ")
                                                      .capitalize());
                                            }).toList(),
                                            Divider(),
                                          ],
                                        );
                                      }).toList()
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Dismiss"))
                                ],
                              );
                            },
                          ).then((value) {
                            setState(() {});
                          });
                        }
                      }
                    }
                  },
                  child: currentPage < formPages.keys.length - 1
                      ? const Text("Next")
                      : const Text("Submit")),
            ),
          ],
        )
      ],
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pages",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ...formPages.keys.toList().map((e) {
              final index = formPages.keys.toList().indexOf(e);
              Color borderColor = Colors.orange;
              if (currentPage == index) {
                borderColor = Colors.orange;
              } else if (widget.readOnly) {
                borderColor = Colors.green;
              } else if (FormInstance.form.control("page_${index}").valid &&
                  FormInstance.form.control("page_${index}").touched) {
                borderColor = Colors.green;
              } else if (FormInstance.form.control("page_${index}").invalid &&
                  FormInstance.form.control("page_${index}").touched) {
                borderColor = Colors.red;
              } else {
                borderColor = Colors.orange;
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  selectedTileColor: Colors.orange.withOpacity(0.2),
                  title: Text(
                    e,
                    style: TextStyle(
                        color:
                            currentPage == index ? Colors.orange : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  selected: currentPage == index,
                  onTap: () {
                    controller.jumpToPage(formPages.keys.toList().indexOf(e));
                    Navigator.pop(context);
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
