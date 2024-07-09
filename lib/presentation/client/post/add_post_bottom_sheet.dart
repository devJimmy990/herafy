import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/validator.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/core/widgets/drop_down.dart';
import 'package:herafy/core/widgets/icon_picker.dart';
import 'package:herafy/core/widgets/inputs.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/data/demo_data.dart';
import 'package:herafy/data/model/client.dart';
import 'package:herafy/data/model/order.dart';
import 'package:herafy/domain/cubit/order/order_cubit.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
import 'package:intl/intl.dart';

class AddPostBottomSheet extends StatefulWidget {
  const AddPostBottomSheet({super.key});

  @override
  State<AddPostBottomSheet> createState() => _AddPostBottomSheetState();
}

class _AddPostBottomSheetState extends State<AddPostBottomSheet> {
  Color checkColor = Colors.grey;
  late String specialty = "سباك", location;
  IconData icon = Icons.more_horiz_rounded;
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Client client = context.read<UserCubit>().user;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
              buildMultiLineTextField(
                maxLines: 3,
                label: "وصف الطلب",
                hint: "برجاء إدخال وصف الطلب",
                isArabic: true,
                controller: descriptionController,
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: IconPicker(
                      isArabic: true,
                      isCenter: true,
                      label: 'إختر المعاد',
                      icon: Icons.calendar_month,
                      controller: dateController,
                      validator: (Validator.generalValidator),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          helpText: "إختر المعاد المناسب لك",
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: CustomDropDownMenu(
                      isArabic: true,
                      value: specialty,
                      label: "إختر التخصص",
                      list: technicainSpecialties,
                      onChanged: (newValue) =>
                          setState(() => specialty = newValue!),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: buildSubmitButton(
                      widthFactor: .8,
                      label: 'إلغاء',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: buildSubmitButton(
                      widthFactor: .8,
                      label: 'إضافة الطلب',
                      onPressed: () {
                        if (isValidInputs()) {
                          context.read<OrderCubit>().addNewOrder(
                                  order: Order(
                                clientID: client.id!,
                                speciality: specialty,
                                location: client.location,
                                date: dateController.text,
                                description: descriptionController.text,
                                clientName: "${client.fName} ${client.lName}",
                              ));
                          SuccessToast.showToast(msg: "تم اضافة الطلب بنجاح");
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: 10), // Add some space before the bottom of the modal
            ],
          ),
        ),
      ),
    );
  }

  bool isValidInputs() {
    if (descriptionController.text.isEmpty) {
      FailureToast.showToast(msg: "برجاء ادخال وصف الطلب");
      return false;
    }
    if (descriptionController.text.length < 20) {
      FailureToast.showToast(msg: "برجاء كتابة وصف طلبك بشكل صحيح و مفصل");
      return false;
    } else if (dateController.text.isEmpty) {
      FailureToast.showToast(msg: "برجاء إختيار المعاد");
      return false;
    } else if (specialty.isEmpty) {
      FailureToast.showToast(msg: "برجاء إختيار التخصص");
      return false;
    } else {
      return true;
    }
  }
}
