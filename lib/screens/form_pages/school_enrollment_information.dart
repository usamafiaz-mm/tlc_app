import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/utils/constants.dart';

class SchoolEnrollmentInformation extends StatelessWidget {
  const SchoolEnrollmentInformation({Key? key, required this.readOnly})
      : super(key: key);
  final bool readOnly;

  FormArray get formArray => FormInstance.form.control('page_4') as FormArray;

  addNewItemToForm() {
    formArray.add(FormGroup({
      "class": FormControl<int>(),
      "boys": FormControl<int>(),
      "girls": FormControl<int>(),
      "total": FormControl<int>(),
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "5.School Enrollment Information",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
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
                        "Class",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ReactiveDropdownField(
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("class") as FormControl<int>,
                        readOnly: readOnly,
                        items: const [
                          DropdownMenuItem(
                            child: Text("Pre-Nursery"),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text("Nursery"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Prep / K.G"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-1"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-2"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-3"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-4"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("Class-5"),
                            value: 7,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Boys",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ReactiveTextField(
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("boys") as FormControl<int>,
                        readOnly: readOnly,
                        style: TextStyle(
                            color: readOnly ? Colors.grey : Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          if (val.value != null &&
                              (formArray.controls[i] as FormGroup)
                                      .control("girls")
                                      .value !=
                                  null) {
                            (formArray.controls[i] as FormGroup)
                                .control("total")
                                .updateValue(val.value! +
                                    (formArray.controls[i] as FormGroup)
                                        .control("girls")
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
                          formControl: (formArray.controls[i] as FormGroup)
                              .control("girls") as FormControl<int>,
                          readOnly: readOnly,
                          style: TextStyle(
                              color: readOnly ? Colors.grey : Colors.black),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            if (val.value != null &&
                                (formArray.controls[i] as FormGroup)
                                        .control("boys")
                                        .value !=
                                    null) {
                              (formArray.controls[i] as FormGroup)
                                  .control("total")
                                  .updateValue(val.value! +
                                      (formArray.controls[i] as FormGroup)
                                          .control("boys")
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
                        readOnly: readOnly,
                        style: TextStyle(
                            color: readOnly ? Colors.grey : Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        formControl: (formArray.controls[i] as FormGroup)
                            .control("total") as FormControl<int>,
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
              onPressed: readOnly ? null : addNewItemToForm,
              child: Text(
                "Add More",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ))
      ],
    );
  }
}
