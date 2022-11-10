import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/constants.dart';

class HigherSchoolEnrollment extends StatelessWidget {
  const HigherSchoolEnrollment({Key? key, required this.readOnly})
      : super(key: key);
  FormArray get formArray => FormInstance.form.control('page_5') as FormArray;
  final bool readOnly;

  addNewItemToForm() {
    formArray.add(FormGroup({
      "class": FormControl<int>(),
      "boys_sci": FormControl<int>(),
      "boys_art": FormControl<int>(),
      "girls_sci": FormControl<int>(),
      "girls_art": FormControl<int>(),
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "6.School Enrollment Information",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        const Text(
          "Higher class wise student enrollment",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        ReactiveFormArray(
          formArray: formArray,
          builder: (context, formArray, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < formArray.controls.length; i++)
                  Column(
                    key: ValueKey(DateTime.now()),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (i > 0)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                              onTap: () {
                                formArray.remove(formArray.controls[i]);
                                print(i);
                              },
                              child: Icon(
                                Icons.minimize,
                                color: Colors.red,
                              )),
                        ),
                      Text(
                        "Higher Class",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ReactiveDropdownField(
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("class") as FormControl<int>,
                        readOnly: readOnly,
                        items: [
                          DropdownMenuItem(
                            child: Text("Class-9"),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-10"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-11"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-12"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("O' Level-Prep"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("O' Level Stage 1"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("O' Level Stage 2"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("A' Level Stage 1"),
                            value: 7,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Boys Sci.",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ReactiveTextField(
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("boys_sci") as FormControl<int>,
                        readOnly: readOnly,
                        style: TextStyle(
                            color: readOnly ? Colors.grey : Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Girls Sci.",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ReactiveTextField(
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("girls_sci") as FormControl<int>,
                        readOnly: readOnly,
                        style: TextStyle(
                            color: readOnly ? Colors.grey : Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Boys Arts",
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
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("boys_art") as FormControl<int>,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Girls Arts",
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
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("girls_art") as FormControl<int>,
                      ),
                      if (i < formArray.controls.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(
                            height: 2,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  )
              ],
            );
          },
        ),
        if (!readOnly)
          TextButton(
              onPressed: addNewItemToForm,
              child: Text(
                "Add More",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ))
      ],
    );
  }
}
