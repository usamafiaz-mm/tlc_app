import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/custom_reactive_widgets/custom_image_picker.dart';
import 'package:tlc_app/widgets/location_widget.dart';

import '../../utils/constants.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({Key? key, required this.readOnly}) : super(key: key);
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            "9. Attach Image Section",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        ReactiveImagePicker(
          formControlName:
              FormInstance.form.control("page_8.image") as FormControl<String>,
          readOnly: readOnly,
        ),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_8.latitude")
              as FormControl<double>,
          builder: (BuildContext context, AbstractControl<double> control,
              Widget? child) {
            if (control.value != null &&
                FormInstance.form.control("page_8.longitude").value != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Longitude",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ReactiveTextField(
                      readOnly: true,
                      style: TextStyle(color: Colors.grey),
                      formControl: FormInstance.form.control("page_8.longitude")
                          as FormControl<double>,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Latitude",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ReactiveTextField(
                      readOnly: true,
                      style: TextStyle(color: Colors.grey),
                      formControl: FormInstance.form.control("page_8.latitude")
                          as FormControl<double>,
                      decoration: InputDecoration(),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        if (!readOnly)
          LocationWidget(
              latController: FormInstance.form.control("page_8.latitude")
                  as FormControl<double>,
              longController: FormInstance.form.control("page_8.longitude")
                  as FormControl<double>),
      ],
    );
  }
}
