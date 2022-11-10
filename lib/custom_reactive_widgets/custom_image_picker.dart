import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveImagePicker extends ReactiveFormField<String?, String?> {
  ReactiveImagePicker(
      {required FormControl<String> formControlName, required bool readOnly})
      : super(
            formControl: formControlName,
            builder: (ReactiveFormFieldState<String?, String?> field) {
              return CustomImagePicker(
                onPressed: () async {
                  if (!readOnly) {
                    formControlName.markAsTouched();
                    final ImagePicker _picker = ImagePicker();
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    field.didChange(photo?.path);
                  }
                },
                path: field.value,
                touched: formControlName.touched,
              );
            });

  @override
  ReactiveFormFieldState<String?, String?> createState() {
    return ReactiveFormFieldState<String?, String?>();
  }
}

class CustomImagePicker extends StatelessWidget {
  CustomImagePicker(
      {Key? key, this.path, required this.onPressed, required this.touched})
      : super(key: key);
  String? path;
  VoidCallback onPressed;
  bool touched;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (touched && path == null)
          const Text(
            "*Select your own Image",
            style: TextStyle(color: Colors.red),
          ),
        InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            height: 250,
            width: 250,
            child: path == null
                ? const Icon(
                    Icons.image_outlined,
                    color: Colors.grey,
                    size: 250,
                  )
                : Image(
                    image: FileImage(
                      File(path!),
                    ),
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
        // ElevatedButton(onPressed: onPressed, child: Text("Pick Image"))
      ],
    );
  }
}
