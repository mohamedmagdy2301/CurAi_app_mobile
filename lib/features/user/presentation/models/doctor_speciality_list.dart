import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/features/user/presentation/models/doctor_speciality_model.dart';

List<DoctorSpecialityModel> doctorSpecialityList = [
  DoctorSpecialityModel(
    id: 0,
    name: LangKeys.general,
    image: AppImages.general,
  ),
  DoctorSpecialityModel(
    id: 1,
    name: LangKeys.ent,
    image: SvgImages.ent,
  ),
  DoctorSpecialityModel(
    id: 2,
    name: LangKeys.pediatric,
    image: AppImages.pediatric,
  ),
  DoctorSpecialityModel(
    id: 3,
    name: LangKeys.urologist,
    image: AppImages.urologist,
  ),
  DoctorSpecialityModel(
    id: 4,
    name: LangKeys.dentistry,
    image: SvgImages.dentistry,
  ),
  DoctorSpecialityModel(
    id: 5,
    name: LangKeys.intestine,
    image: SvgImages.intestine,
  ),
  DoctorSpecialityModel(
    id: 6,
    name: LangKeys.histologist,
    image: SvgImages.histologist,
  ),
  DoctorSpecialityModel(
    id: 7,
    name: LangKeys.hepatology,
    image: SvgImages.hepatology,
  ),
  DoctorSpecialityModel(
    id: 8,
    name: LangKeys.cardiologist,
    image: SvgImages.cardiologist,
  ),
  DoctorSpecialityModel(
    id: 9,
    name: LangKeys.neurologic,
    image: AppImages.neurologic,
  ),
  DoctorSpecialityModel(
    id: 10,
    name: LangKeys.pulmonary,
    image: SvgImages.pulmonary,
  ),
  DoctorSpecialityModel(
    id: 11,
    name: LangKeys.optometry,
    image: SvgImages.optometry,
  ),
];
