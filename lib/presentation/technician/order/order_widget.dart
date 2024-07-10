import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/data/model/order.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/domain/cubit/order/order_cubit.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';

class OrderCard extends StatefulWidget {
  final bool isView;
  final Order order;
  const OrderCard({super.key, required this.order, this.isView = false});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: "تم نشره فى : ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                  text: widget.order.postedDate,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ))
            ])),
            const Text(
              ":تفاصيل الطلب",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              widget.order.description,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Visibility(
                visible: isExpanded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    moreOrderInfo(
                      icon: Icons.person,
                      label: "إسم العميل: ",
                      value: widget.order.clientName,
                    ),
                    moreOrderInfo(
                      icon: Icons.calendar_month,
                      label: "التاريخ: ",
                      value: widget.order.date,
                    ),
                    moreOrderInfo(
                      icon: Icons.location_on,
                      label: "العنوان: ",
                      value: widget.order.location.toString(),
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: buildSubmitButton(
                    widthFactor: .8,
                    label: isExpanded ? "إخفاء المزيد" : "عرض المزيد",
                    hrPadding: 20,
                    vrPadding: 10,
                    bgColor: Colors.blue,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    onPressed: () => setState(() => isExpanded = !isExpanded),
                  ),
                ),
                const SizedBox(width: 8),
                widget.isView
                    ? const SizedBox()
                    : Expanded(
                        child: buildSubmitButton(
                          widthFactor: .8,
                          label: "تقديم عرض",
                          hrPadding: 20,
                          vrPadding: 10,
                          bgColor: Colors.green,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          onPressed: () {
                            try {
                              final Technician technician =
                                  context.read<UserCubit>().user;
                              SuccessToast.showToast(msg: "${technician.id}");
                              context.read<OrderCubit>().addProposal(
                                    orderID: widget.order.id,
                                    technician: technician,
                                  );
                              SuccessToast.showToast(msg: "تم تقديم عرض بنجاح");
                            } catch (e) {
                              FailureToast.showToast(
                                  msg: "حدث خطاء في تقديم العرض");
                            }
                          },
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

moreOrderInfo(
    {required IconData icon, required String label, required String value}) {
  return RichText(
    textDirection: TextDirection.rtl,
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Icon(
            icon,
            color: Colors.black,
            size: 16 * 1.2, // Adjust size as needed
          ),
        ),
        TextSpan(
          text: label,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(color: Colors.black, fontSize: 17),
        ),
      ],
    ),
  );
}
