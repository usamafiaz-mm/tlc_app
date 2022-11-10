import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveRadioGroup extends ReactiveFormField<String?, String?> {
  CustomReactiveRadioGroup(
      {super.key, required FormControl<String> formControl})
      : super(
            formControl: formControl,
            builder: (ReactiveFormFieldState<String?, String?> field) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (formControl.invalid && formControl.touched)
                                ? Colors.red
                                : Colors.transparent)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ReactiveRadioListTile(
                          selectedTileColor: Colors.green,

                          title: const Text("Yes"),
                          // toggleable: true,
                          value: "yes",

                          formControl: formControl,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ReactiveRadioListTile(
                          selectedTileColor: Colors.green,
                          activeColor: Colors.green,
                          title: const Text("No"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey)),
                          value: "no",
                          formControl: formControl,
                        ),
                      ],
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
