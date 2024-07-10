import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/widgets/buttons.dart';
import 'package:herafy/core/widgets/toast.dart';
import 'package:herafy/data/model/order.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/domain/cubit/chat/chat_cubit.dart';
import 'package:herafy/presentation/chat/chat_screen.dart';
import 'package:herafy/presentation/client/post/post_card.dart';

import '../../../data/model/client.dart';
import '../../../domain/cubit/user/user_cubit.dart';

class PostDetails extends StatelessWidget {
  final Order order;
  const PostDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final Client client = context.read<UserCubit>().user as Client;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    postDetails(order: order),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order.proposals.length,
                itemBuilder: (context, index) => proposalCard(
                  userId: client.id!,
                  context: context,
                  technician: order.proposals[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget proposalCard(
    {required Technician technician, required context, required userId}) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    // padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.amber,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/technicain.png"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${technician.fName} ${technician.lName}'),
                    Text(technician.phone),
                    Text(
                      technician.location.toString(),
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: buildSubmitButton(
                hrPadding: 10,
                widthFactor: .8,
                label: "قبول العرض",
                bgColor: Colors.green,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                onPressed: () {
                  // print(technician.fName);
                  ChatCubit.get(context)
                      .checkConversation(userId!, technician.id!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                receiverId: technician.id!,
                                receiverName:
                                    "${technician.fName} ${technician.lName}",
                                technicianSpeciality: technician.speciality,
                              )));
                  SuccessToast.showToast(msg: "قبول العرض");
                },
              ),
            ),
            Expanded(
              child: buildSubmitButton(
                hrPadding: 10,
                widthFactor: .8,
                bgColor: Colors.blue,
                label: "عرض الملف الشخصي",
                style: const TextStyle(fontSize: 16, color: Colors.white),
                onPressed: () {
                  SuccessToast.showToast(msg: "عرض الملف الشخصي");
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
