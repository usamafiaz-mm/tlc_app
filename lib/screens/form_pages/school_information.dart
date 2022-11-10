import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/utils/CustomDateAccessor.dart';
import 'package:tlc_app/utils/constants.dart';

class SchoolInformation extends StatelessWidget {
  const SchoolInformation({Key? key, required this.readOnly}) : super(key: key);
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "2.School Basic Information",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Year of Establishment*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          formControl: FormInstance.form.control("page_1.year_of_establishment")
              as FormControl<int>,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
            hintText: "year of establishment",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "School Location",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
          readOnly: readOnly,
          formControl: FormInstance.form.control("page_1.school_location")
              as FormControl<String>,
          items: [
            DropdownMenuItem(
              child: Text("Rural"),
              value: "Rural",
            ),
            DropdownMenuItem(
              child: Text("Urban"),
              value: "Urban",
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Level of School",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
          readOnly: readOnly,
          formControl: FormInstance.form.control("page_1.level_of_school")
              as FormControl<String>,
          items: [
            DropdownMenuItem(
              child: Text("Primary"),
              value: "Primary",
            ),
            DropdownMenuItem(
              child: Text("Middle"),
              value: "Middle",
            ),
            DropdownMenuItem(
              child: Text("Elementary"),
              value: "Elementary",
            ),
            DropdownMenuItem(
              child: Text("Secondary"),
              value: "Secondary",
            ),
            DropdownMenuItem(
              child: Text("Higher Secondary"),
              value: "Higher Secondary",
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Gender",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            formControl: FormInstance.form.control("page_1.gender")
                as FormControl<String>,
            items: [
              DropdownMenuItem(
                child: Text("Male"),
                value: "Male",
              ),
              DropdownMenuItem(
                child: Text("Female"),
                value: "Female",
              ),
              DropdownMenuItem(
                child: Text("Mixed"),
                value: "Mixed",
              ),
            ]),
        SizedBox(
          height: 16,
        ),
        Text(
          "School Category",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            formControl: FormInstance.form.control("page_1.school_category")
                as FormControl<String>,
            items: [
              DropdownMenuItem(
                child: Text("School"),
                value: "School",
              ),
              DropdownMenuItem(
                child: Text("Madrassa"),
                value: "Madrassa",
              ),
              DropdownMenuItem(
                child: Text("School and Madrassa Both"),
                value: "School and Madrassa Both",
              ),
            ]),
        SizedBox(
          height: 16,
        ),
        Text(
          "Teaching Medium",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            formControl: FormInstance.form.control("page_1.teaching_medium")
                as FormControl<String>,
            items: [
              DropdownMenuItem(
                child: Text("English"),
                value: "English",
              ),
              DropdownMenuItem(
                child: Text("Urdu"),
                value: "Urdu",
              ),
              DropdownMenuItem(
                child: Text("Sindhi"),
                value: "Sindhi",
              ),
            ]),
        SizedBox(
          height: 16,
        ),
        Text(
          "Number of Classrooms*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          formControl: FormInstance.form.control("page_1.number_of_classrooms")
              as FormControl<int>,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
            hintText: "Number of Class rooms",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Building ownership",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            formControl: FormInstance.form.control("page_1.building_ownership")
                as FormControl<String>,
            items: [
              DropdownMenuItem(
                child: Text("Govt."),
                value: "Govt.",
              ),
              DropdownMenuItem(
                child: Text("Private Owned"),
                value: "Private Owned",
              ),
              DropdownMenuItem(
                child: Text("Rented"),
                value: "Rented",
              ),
              DropdownMenuItem(
                child: Text("Other"),
                value: "Other",
              ),
            ]),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_1.building_ownership"),
          builder: (context, control, child) {
            if (control.value == "Other") {
              return Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Other Detail",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ReactiveTextField(
                    readOnly: readOnly,
                    style:
                        TextStyle(color: readOnly ? Colors.grey : Colors.black),
                    formControl:
                        FormInstance.form.control("page_1.other_ownership")
                            as FormControl<String>,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Which of the textbooks are being used in school?",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            formControl: FormInstance.form.control("page_1.type_textbooks")
                as FormControl<String>,
            items: [
              DropdownMenuItem(
                child: Text("STBB"),
                value: "STBB",
              ),
              DropdownMenuItem(
                child: Text("Oxford"),
                value: "Oxford",
              ),
              DropdownMenuItem(
                child: Text("Cambridge"),
                value: "Cambridge",
              ),
              DropdownMenuItem(
                child: Text("Others"),
                value: "Others",
              ),
            ]),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_1.type_textbooks"),
          builder: (context, control, child) {
            if (control.value == "Others") {
              return Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "If others, please specify",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ReactiveTextField(
                    readOnly: readOnly,
                    style:
                        TextStyle(color: readOnly ? Colors.grey : Colors.black),
                    formControl:
                        FormInstance.form.control("page_1.other_type_textbooks")
                            as FormControl<String>,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
