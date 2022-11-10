import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/utils/constants.dart';

import '../../custom_reactive_widgets/cst_reactive_radio_group.dart';

class RegistrationInformation extends StatelessWidget {
  const RegistrationInformation({Key? key, required this.readOnly})
      : super(key: key);
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "3.Registration Information",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Registration Status",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            hint: const Text("Registration Status"),
            formControl: FormInstance.form.control("page_2.reg_status")
                as FormControl<int>,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('Registered'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('Not Registered'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('Under Process'),
              ),
            ]),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_2.reg_status"),
          builder: (context, control, child) {
            if (control.value == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Registration #",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ReactiveTextField(
                    readOnly: readOnly,
                    style:
                        TextStyle(color: readOnly ? Colors.grey : Colors.black),
                    formControl: FormInstance.form.control("page_2.reg_number")
                        as FormControl<String>,
                    keyboardType: TextInputType.text,
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
          "Is this School Affaliated with BISE",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_2.affiliation_status")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_2.affiliation_status"),
          builder: (BuildContext context, AbstractControl<dynamic> control,
              Widget? child) {
            if (control.value == 'yes') {
              FormInstance.form
                  .control("page_2.other_than_bise")
                  .reset(removeFocus: true);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name of BISE",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ReactiveDropdownField(
                    formControl: FormInstance.form
                        .control("page_2.name_of_bise") as FormControl<int>,
                    readOnly: readOnly,
                    items: const [
                      DropdownMenuItem(
                        child: Text("BISE Aga Khan"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("BISE Karachi"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("BISE Hyderabad"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("BISE Sukkur"),
                        value: 3,
                      ),
                    ],
                  ),
                ],
              );
            } else if (control.value == "no") {
              FormInstance.form
                  .control("page_2.name_of_bise")
                  .reset(removeFocus: true);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "If Affaliated other than BISE",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ReactiveTextField(
                    formControl:
                        FormInstance.form.control("page_2.other_than_bise")
                            as FormControl<String>,
                    readOnly: true,
                    style:
                        TextStyle(color: readOnly ? Colors.grey : Colors.black),
                  )
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}
