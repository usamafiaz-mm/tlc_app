import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveRadioGroup extends ReactiveFormField<String?, String?> {
  CustomReactiveRadioGroup(
      {super.key,
      required FormControl<String> formControl,
      required bool readOnly})
      : super(
            formControl: formControl,
            builder: (ReactiveFormFieldState<String?, String?> field) {
              Color borderColor;
              bool error = false;
              if (readOnly) {
                borderColor = Colors.grey.withOpacity(0.4);
              } else if (formControl.value == null && formControl.touched) {
                borderColor = Colors.red;
                error = true;
              } else {
                borderColor = Colors.grey;
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: ReactiveRadioListTile(
                      selectedTileColor: Colors.green,

                      title: const Text("Yes"),
                      // toggleable: true,
                      value: "yes",

                      formControl: formControl,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: ReactiveRadioListTile(
                      selectedTileColor: Colors.green,
                      activeColor: Colors.green,
                      title: const Text("No"),
                      value: "no",
                      formControl: formControl,
                    ),
                  ),
                  if (formControl.invalid && formControl.touched)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "required",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                ],
              );
            });
}
