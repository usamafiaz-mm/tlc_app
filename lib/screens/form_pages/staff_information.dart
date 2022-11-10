import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/constants.dart';

class StaffInformation extends StatelessWidget {
  const StaffInformation({Key? key, required this.readOnly}) : super(key: key);
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "8.Total no. of Staff Information",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Teaching Male Staff",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 4,
        ),
        ReactiveTextField(
          formControl: FormInstance.form.control("page_7.teaching_male_staff")
              as FormControl<int>,
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (val) {
            if (val.value != null &&
                FormInstance.form
                        .control("page_7.teaching_female_staff")
                        .value !=
                    null) {
              FormInstance.form
                  .control("page_7.total_teaching_staff")
                  .updateValue(val.value! +
                      FormInstance.form
                          .control("page_7.teaching_female_staff")
                          .value);
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Teaching Female Staff",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          formControl: FormInstance.form.control("page_7.teaching_female_staff")
              as FormControl<int>,
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (val) {
            if (val.value != null &&
                FormInstance.form.control("page_7.teaching_male_staff").value !=
                    null) {
              FormInstance.form
                  .control("page_7.total_teaching_staff")
                  .updateValue(val.value! +
                      FormInstance.form
                          .control("page_7.teaching_male_staff")
                          .value);
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Total Teaching Staff",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 4,
        ),
        ReactiveTextField(
          formControl: FormInstance.form.control("page_7.total_teaching_staff")
              as FormControl<int>,
          readOnly: true,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Non Teaching Male Staff",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          formControl: FormInstance.form
              .control("page_7.non_teaching_male_staff") as FormControl<int>,
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (val) {
            if (val.value != null &&
                FormInstance.form
                        .control("page_7.non_teaching_female_staff")
                        .value !=
                    null) {
              FormInstance.form
                  .control("page_7.total_non_teaching_staff")
                  .updateValue(val.value! +
                      FormInstance.form
                          .control("page_7.non_teaching_female_staff")
                          .value);
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Non Teaching Female Staff",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          formControl: FormInstance.form
              .control("page_7.non_teaching_female_staff") as FormControl<int>,
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (val) {
            if (val.value != null &&
                FormInstance.form
                        .control("page_7.non_teaching_male_staff")
                        .value !=
                    null) {
              FormInstance.form
                  .control("page_7.total_non_teaching_staff")
                  .updateValue(val.value! +
                      FormInstance.form
                          .control("page_7.non_teaching_male_staff")
                          .value);
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Total Non Teaching Staff",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          formControl: FormInstance.form
              .control("page_7.total_non_teaching_staff") as FormControl<int>,
          readOnly: true,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ],
    );
  }
}
