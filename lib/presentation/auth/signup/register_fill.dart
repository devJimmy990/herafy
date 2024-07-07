import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/location.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/helper/validator.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/core/widgets/drop_down.dart';
import 'package:herafy/core/widgets/icon_picker.dart';
import 'package:herafy/core/widgets/inputs.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/data/model/client.dart';
import 'package:herafy/data/model/location.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/domain/cubit/auth/auth_state.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
import 'package:intl/intl.dart';

class RegisterationFillDataPage extends StatefulWidget {
  const RegisterationFillDataPage({super.key});

  @override
  State<RegisterationFillDataPage> createState() =>
      _RegisterationFillDataPageState();
}

class _RegisterationFillDataPageState extends State<RegisterationFillDataPage> {
  // File? image;
  String type = "عميل";
  String speciality = "إختر التخصص";
  bool isDefault = true;
  String gender = "ذكر";
  late Location location;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  // Future<void> _pickImage() async {
  //   debugPrint("sda");
  //   // final pickedFile =
  //   //     await ImagePicker().pickImage(source: ImageSource.gallery);

  //   // if (pickedFile != null) {
  //   //   setState(() {
  //   //     image = File(pickedFile.path);
  //   //   });
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                            radius: 80,
                            child: Image.asset("assets/images/profile.png")),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField(
                            isArabic: true,
                            icon: Icons.person,
                            label: 'الإسم الثانى',
                            controller: _lNameController,
                            validator: (Validator.nameValidator),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: buildTextField(
                            isArabic: true,
                            icon: Icons.person,
                            label: 'الإسم الأول',
                            controller: _fNameController,
                            validator: (Validator.nameValidator),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomDropDownMenu(
                            isArabic: true,
                            value: gender,
                            label: "النوع",
                            list: const ["ذكر", "إنثى"],
                            onChanged: (String? newVal) =>
                                setState(() => gender = newVal!),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: buildNumberField(
                            isArabic: true,
                            label: "رقم الهاتف",
                            icon: Icons.phone_android,
                            controller: _phoneController,
                            validator: (Validator.phoneValidator),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: IconPicker(
                              isArabic: true,
                              isCenter: true,
                              label: 'تاريخ الميلاد',
                              icon: Icons.calendar_month,
                              controller: _birthDateController,
                              validator: (Validator.generalValidator),
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  helpText: "Select Birth Date",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _birthDateController.text =
                                        DateFormat('yyyy-MM-dd').format(picked);
                                  });
                                }
                              },
                            )),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: IconPicker(
                              isArabic: true,
                              label: 'العنوان',
                              icon: Icons.location_on,
                              controller: _locationController,
                              validator: (Validator.generalValidator),
                              onPressed: () async {
                                try {
                                  CustomLocation().accessLocation(
                                    callBack: (position) => setState(
                                      () {
                                        location = Location.fromJson(position);
                                        _locationController.text =
                                            "${position["street"]}, ${position["area"]} - ${position["city"]}";
                                      },
                                    ),
                                  );
                                } catch (e) {
                                  // print("Errooooooooooor: ${e.toString()}");
                                  FailureToast.showToast(
                                      msg: Validator.locationValidator(
                                          e.toString()));
                                }
                              }),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: isDefault ? false : true,
                          child: Expanded(
                            flex: 3,
                            child: CustomDropDownMenu(
                              value: speciality,
                              isArabic: true,
                              label: "إختيار نوع المستخدم",
                              list: const [
                                "إختر التخصص",
                                "سباك",
                                "نجار",
                                "كهربائى",
                                "خياط",
                                "ميكانيكى",
                                "بناء",
                                "دهان"
                              ],
                              onChanged: (String? newVal) =>
                                  setState(() => speciality = newVal!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: CustomDropDownMenu(
                            value: type,
                            isArabic: true,
                            label: "إختيار نوع المستخدم",
                            list: const ["عميل", "حرفى"],
                            onChanged: (String? newVal) => setState(() {
                              type = newVal!;
                              isDefault = type == "عميل" ? true : false;
                            }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccessFillData) {
                          dynamic user = state.data;
                          context.read<UserCubit>().setUserData(user);

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            user.type == "client"
                                ? Routes.clientHome
                                : Routes.technicianHome,
                            (route) => false,
                          );
                        } else if (state is AuthError) {
                          FailureToast.showToast(
                              msg: Validator.firebaseRegisterValidator(
                            state.message,
                          ));
                        }
                      },
                      builder: (context, state) {
                        return state is AuthLoading
                            ? const Center(child: CircularProgressIndicator())
                            : buildSubmitButton(
                                label: "تأكيد البيانات",
                                widthFactor: .7,
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ==
                                          true &&
                                      state is! AuthLoading) {
                                    type == "عميل"
                                        ? context
                                            .read<AuthCubit>()
                                            .fillClientData(
                                              client: Client(
                                                gender: gender,
                                                location: location,
                                                fName: _fNameController.text,
                                                lName: _lNameController.text,
                                                phone: _phoneController.text,
                                                birthDate:
                                                    _birthDateController.text,
                                              ),
                                            )
                                        : context
                                            .read<AuthCubit>()
                                            .fillTechnicianData(
                                              technician: Technician(
                                                gender: gender,
                                                location: location,
                                                speciality: speciality,
                                                fName: _fNameController.text,
                                                lName: _lNameController.text,
                                                phone: _phoneController.text,
                                                birthDate:
                                                    _birthDateController.text,
                                              ),
                                            );
                                  }
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isInputsValid() {
    if (_fNameController.text.isEmpty ||
        _lNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _birthDateController.text.isEmpty) {
      return false;
    }

    if (_fNameController.text.isEmpty) {
      FailureToast.showToast(msg: "First Name");
      return false;
    }
    return true;
  }
}
