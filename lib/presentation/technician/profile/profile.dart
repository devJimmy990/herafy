import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/widgets/appbar_icon.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Technician technician = context.read<UserCubit>().user as Technician;
    return Scaffold(
        appBar: MyCustomAppBar(
          removeLeading: true,
          title: "الملف الشخصي",
          actions: [
            appBarIcon(
              icon: Icons.logout,
              onTap: () {
                context.read<AuthCubit>().signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              },
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-photo/there-is-cat-that-is-sitting-ledge-chinese-garden-generative-ai_900396-35755.jpg'), // Replace with your image asset
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          technician.fName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          technician.lName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      technician.phone,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                size: 25,
                                weight: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                technician.location.toString().substring(0, 30),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(
                                Icons.construction,
                                size: 25,
                                weight: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                technician.speciality,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_3_rounded,
                                size: 25,
                                weight: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                technician.gender,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                size: 25,
                                weight: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                technician.birthDate,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                " (${AgeCalculator.age(DateTime.parse(technician.birthDate)).years} Years Old)",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
