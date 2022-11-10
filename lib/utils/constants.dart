import 'package:reactive_forms/reactive_forms.dart';

class FormInstance {
  static final form = FormGroup({
    "page_0": FormGroup({
      "census_year": FormControl<int>(validators: [Validators.required]),
      "date": FormControl<String>(validators: [Validators.required]),
      "emis_code": FormControl<int>(validators: [Validators.required]),
      "region": FormControl<String>(validators: [Validators.required]),
      "district": FormControl<String>(validators: [Validators.required]),
      "tehsil": FormControl<String>(validators: [Validators.required]),
      "uc_mc_tc_name": FormControl<String>(validators: [Validators.required]),
      "school_name": FormControl<String>(validators: [Validators.required]),
      "address": FormControl<String>(validators: [Validators.required]),
      "tel_no": FormControl<String>(),
      "school_area": FormControl<String>(),
    }),
    "page_1": FormGroup({
      "year_of_establishment":
          FormControl<int>(validators: [Validators.required]),
      "number_of_classrooms":
          FormControl<int>(validators: [Validators.required]),
      "school_location": FormControl<String>(),
      "level_of_school": FormControl<String>(),
      "gender": FormControl<String>(),
      "school_category": FormControl<String>(),
      "teaching_medium": FormControl<String>(),
      "building_ownership": FormControl<String>(),
      "other_ownership": FormControl<String>(),
      "type_textbooks": FormControl<String>(),
      "other_type_textbooks": FormControl<String>(),
    }),
    "page_2": FormGroup({
      "reg_status": FormControl<int>(validators: [Validators.required]),
      "affiliation_status":
          FormControl<String>(validators: [Validators.required]),
      "reg_number": FormControl<String>(),
      "name_of_bise": FormControl<int>(),
      "other_than_bise": FormControl<String>(),
    }),
    "page_3": FormGroup({
      "drinking_water": FormControl<String>(),
      "boundary_wall": FormControl<String>(),
      "electricity": FormControl<String>(),
      "toilet": FormControl<String>(),
      "staff_room": FormControl<String>(),
      "play_ground": FormControl<String>(),
      "ups_generator": FormControl<String>(),
      "multi_purpose_hall": FormControl<String>(),
      "office_computer": FormControl<String>(),
      "science_lab": FormControl<String>(),
      "library": FormControl<String>(),
      "internet": FormControl<String>(),
      "transport_for_student": FormControl<String>(),
    }),
    "page_4": FormArray([
      FormGroup({
        "class": FormControl<int>(),
        "boys": FormControl<int>(),
        "girls": FormControl<int>(),
        "total": FormControl<int>(),
      }),
    ]),
    "page_5": FormArray([
      FormGroup({
        "class": FormControl<int>(),
        "boys_sci": FormControl<int>(),
        "boys_art": FormControl<int>(),
        "girls_sci": FormControl<int>(),
        "girls_art": FormControl<int>(),
      }),
    ]),
    "page_6": FormGroup({
      "minority_students_exist": FormControl<String>(),
      "boys": FormControl<int>(),
      "girls": FormControl<int>(),
      "total": FormControl<int>(),
    }),
    "page_7": FormGroup({
      "teaching_male_staff": FormControl<int>(),
      "teaching_female_staff": FormControl<int>(),
      "total_teaching_staff": FormControl<int>(),
      "non_teaching_male_staff": FormControl<int>(),
      "non_teaching_female_staff": FormControl<int>(),
      "total_non_teaching_staff": FormControl<int>(),
    }),
    "page_8": FormGroup({
      "image": FormControl<String>(validators: [Validators.required]),
      "latitude": FormControl<double>(validators: [Validators.required]),
      "longitude": FormControl<double>(validators: [Validators.required]),
    })
  });
}
