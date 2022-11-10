import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tlc_app/utils/CustomDateAccessor.dart';
import 'package:tlc_app/utils/constants.dart';

class CensusInformation extends StatelessWidget {
  CensusInformation({Key? key, required this.readOnly}) : super(key: key);
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "1.Census Information",
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Census Year*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            hint: const Text("Select Designation"),
            formControl: FormInstance.form.control("page_0.census_year")
                as FormControl<int>,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('2021-22'),
              ),
            ]),
        SizedBox(
          height: 16,
        ),
        Text(
          "Date*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDatePicker(
          formControl:
              FormInstance.form.control("page_0.date") as FormControl<String>,
          firstDate: DateTime(1900, 1, 1),
          lastDate: DateTime(2030, 12, 3),
          builder: (context, picker, child) {
            return ReactiveTextField(
              style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
              formControl: FormInstance.form.control("page_0.date")
                  as FormControl<String>,
              readOnly: true,
              valueAccessor:
                  CustomDateValueAccessor(format: DateFormat("dd-MM-yyyy")),
              onTap: (_) {
                if (!readOnly) picker.showPicker();
              },
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  hintText: "Date",
                  enabled: false),
            );
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Region*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveDropdownField(
            readOnly: readOnly,
            formControl: FormInstance.form.control("page_0.region")
                as FormControl<String>,
            items: [
              DropdownMenuItem(
                child: Text("SUKKUR"),
                value: "SUKKUR",
              ),
              DropdownMenuItem(
                child: Text("SBA at NawabShah"),
                value: "SBA at NawabShah",
              ),
              DropdownMenuItem(
                child: Text("Mirpurkhas"),
                value: "Mirpurkhas",
              ),
              DropdownMenuItem(
                child: Text("Larkana"),
                value: "Larkana",
              ),
              DropdownMenuItem(
                child: Text("Karachi"),
                value: "Karachi",
              ),
              DropdownMenuItem(
                child: Text("Hyderabad"),
                value: "Hyderabad",
              ),
            ]),
        SizedBox(
          height: 16,
        ),
        Text(
          "District*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_0.region"),
          builder: (context, control, child) {
            return ReactiveDropdownField(
                readOnly: readOnly,
                formControl: FormInstance.form.control("page_0.district")
                    as FormControl<String>,
                items: getDistricts(
                    FormInstance.form.control("page_0.region").value));
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Tehsil*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_0.district"),
          builder: (context, control, child) {
            return ReactiveDropdownField(
                readOnly: readOnly,
                formControl: FormInstance.form.control("page_0.tehsil")
                    as FormControl<String>,
                items: getTehsil(
                    FormInstance.form.control("page_0.district").value));
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "UC/MC/TC Name*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveValueListenableBuilder(
          formControl: FormInstance.form.control("page_0.tehsil"),
          builder: (context, control, child) {
            return ReactiveDropdownField(
                readOnly: readOnly,
                style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
                formControl: FormInstance.form.control("page_0.uc_mc_tc_name")
                    as FormControl<String>,
                items: getUc(FormInstance.form.control("page_0.tehsil").value));
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "EMIS Code*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          readOnly: readOnly,
          formControl:
              FormInstance.form.control("page_0.emis_code") as FormControl<int>,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
              hintText: "EMIS Code",
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Name of School*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          formControl: FormInstance.form.control("page_0.school_name")
              as FormControl<String>,
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Address*",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          formControl: FormInstance.form.control("page_0.address")
              as FormControl<String>,
          keyboardType: TextInputType.text,
          maxLines: 5,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Tel no",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          formControl:
              FormInstance.form.control("page_0.tel_no") as FormControl<String>,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Total Area of School(in square ft)",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 8,
        ),
        ReactiveTextField(
          readOnly: readOnly,
          style: TextStyle(color: readOnly ? Colors.grey : Colors.black),
          formControl: FormInstance.form.control("page_0.school_area")
              as FormControl<String>,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ],
    );
  }

  List<DropdownMenuItem> getDistricts(String? region) {
    switch (region) {
      case "SUKKUR":
        return ["Gotki", "Sukkur", "Khairpur Mirs"]
            .map((String e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList();
      case "SBA at NawabShah":
        return ["Naushero Feroze", "Sanghar", "Shaheed Benazirabad"]
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList();
      case "Mirpurkhas":
        return ["Mirpurkhas", "Tharparkar at Mithi"]
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList();
      case "Larkana":
        return [
          "Kashmore at Kandhkot",
          "Kambar at Shahdadkot",
          "Larkana",
          "Jacobabad",
          "Shikarpur"
        ]
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList();
      case "Karachi":
        return [
          "Karachi Malir",
          "Karachi West",
          "Karachi South",
          "Karachi Korangi",
          "Karachi East",
          "Karachi Central",
          "Karachi Keamari"
        ]
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList();
      default:
        return [];
    }
  }

  List<DropdownMenuItem> getTehsil(String? district) {
    switch (district) {
      case null:
        return [];
      case "Gotki":
        return ["Ghotki", "Ubauro"]
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList();

      default:
        return [
          DropdownMenuItem(
            child: Text(district!),
            value: district,
          )
        ];
    }
  }

  List<DropdownMenuItem> getUc(String? tehsil) {
    switch (tehsil) {
      case null:
        return [];
      default:
        return [
          DropdownMenuItem(
            child: Text(tehsil!),
            value: tehsil,
          )
        ];
    }
  }
}
