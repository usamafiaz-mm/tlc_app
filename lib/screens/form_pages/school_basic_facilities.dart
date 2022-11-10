import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/utils/constants.dart';

import '../../custom_reactive_widgets/cst_reactive_radio_group.dart';

class SchoolBasicFacilities extends StatelessWidget {
  const SchoolBasicFacilities({Key? key, required this.readOnly})
      : super(key: key);
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FittedBox(
          child: Text(
            "4.School Basic Information",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Drinking Water",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.drinking_water")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Boundary Wall",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.boundary_wall")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Electricity",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.electricity")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Toilet",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl:
              FormInstance.form.control("page_3.toilet") as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Staff Room",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.staff_room")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Playground",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.play_ground")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "UPS / Generator",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.ups_generator")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Multi-purpose Hall",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.multi_purpose_hall")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Office Computer",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.office_computer")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Science Lab",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.science_lab")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Library",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.library")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Internet",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.internet")
              as FormControl<String>,
          readOnly: readOnly,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Transport for students by the school",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomReactiveRadioGroup(
          formControl: FormInstance.form.control("page_3.transport_for_student")
              as FormControl<String>,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
