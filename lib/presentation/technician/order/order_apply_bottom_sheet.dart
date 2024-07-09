import 'package:flutter/material.dart';
import 'package:herafy/core/widgets/inputs.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/core/widgets/app_text_button.dart';
import 'package:herafy/data/model/order.dart';

class OrderApplyBottomSheet extends StatefulWidget {
  final Order order;
  const OrderApplyBottomSheet({super.key, required this.order});

  @override
  State<OrderApplyBottomSheet> createState() => _OrderApplyBottomSheetState();
}

class _OrderApplyBottomSheetState extends State<OrderApplyBottomSheet> {
  late TextEditingController controller;
  // late FocusNode focusNode;
  @override
  void initState() {
    controller = TextEditingController();
    // focusNode = FocusNode();
    // focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            buildMultiLineTextField(
              maxLines: 10,
              // focusNode: focusNode,
              controller: controller,
              label: "تفاصيل العرض",
              hint: "برجاء إدخال تفاصيل العرض",
              validator: (validator) {
                return null;
              },
            ),
            const SizedBox(height: 30),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppTextButton(
                      buttonText: "إلغاء",
                      buttonHeight: 50,
                      backgroundColor: Colors.red,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onPressed: _cancelPrescription),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppTextButton(
                      buttonText: "تأكيد العرض",
                      buttonHeight: 50,
                      backgroundColor: Colors.green,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onPressed: _submitPrescription),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _cancelPrescription() {
    Navigator.of(context).pop();
  }

  void _submitPrescription() {
    try {} catch (e) {
      FailureToast.showToast(msg: e.toString());
    }
  }
}
