import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/custom_reactive_widgets/cst_reactive_radio_group.dart';
import 'package:tlc_app/utils/constants.dart';

class OtherStudentEnrollment extends StatelessWidget {
  const OtherStudentEnrollment({Key? key, required this.readOnly})
      : super(key: key);
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "7.Other Students Enrollment",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Are there any minority students enrolled in school?",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
            readOnly: readOnly,
            formControl:
                FormInstance.form.control("page_6.minority_students_exist")
                    as FormControl<String>),
        SizedBox(
          height: 16,
        ),
        ReactiveValueListenableBuilder(
            formControl:
                FormInstance.form.control("page_6.minority_students_exist"),
            builder: (context, control, child) {
              if (control.value == "yes") {
                FormInstance.form.control("page_6.boys").markAsEnabled();
                FormInstance.form.control("page_6.girls").markAsEnabled();
                FormInstance.form.control("page_6.total").markAsEnabled();
              } else {
                FormInstance.form.control("page_6.boys").markAsDisabled();
                FormInstance.form.control("page_6.girls").markAsDisabled();
                FormInstance.form.control("page_6.total").markAsDisabled();
              }
              return Visibility(
                visible: control.value == "yes",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Boys",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ReactiveTextField(
                      formControl: FormInstance.form.control("page_6.boys")
                          as FormControl<int>,
                      readOnly: readOnly,
                      style: TextStyle(
                          color: readOnly ? Colors.grey : Colors.black),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (val) {
                        if (val.value != null &&
                            FormInstance.form.control("page_6.girls").value !=
                                null) {
                          FormInstance.form.control("page_6.total").updateValue(
                              val.value! +
                                  FormInstance.form
                                      .control("page_6.girls")
                                      .value);
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Girls",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ReactiveTextField(
                        formControl: FormInstance.form.control("page_6.girls")
                            as FormControl<int>,
                        readOnly: readOnly,
                        style: TextStyle(
                            color: readOnly ? Colors.grey : Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          if (val.value != null &&
                              FormInstance.form.control("page_6.boys").value !=
                                  null) {
                            FormInstance.form
                                .control("page_6.total")
                                .updateValue(val.value! +
                                    FormInstance.form
                                        .control("page_6.boys")
                                        .value);
                          }
                        }),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ReactiveTextField(
                      keyboardType: TextInputType.number,
                      readOnly: readOnly,
                      style: TextStyle(
                          color: readOnly ? Colors.grey : Colors.black),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      formControl: FormInstance.form.control("page_6.total")
                          as FormControl<int>,
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
