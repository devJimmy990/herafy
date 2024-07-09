import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/routes.dart';
import 'package:herafy/core/widgets/appbar_icon.dart';
import 'package:herafy/core/widgets/custom_app_bar.dart';
import 'package:herafy/data/model/client.dart';
import 'package:herafy/domain/cubit/auth/auth_cubit.dart';
import 'package:herafy/domain/cubit/user/user_cubit.dart';
// import 'package:herafy/presentation/client/profile/post_card.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final Client client = context.read<UserCubit>().user as Client;
    return Scaffold(
      appBar: MyCustomAppBar(
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
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-photo/there-is-cat-that-is-sitting-ledge-chinese-garden-generative-ai_900396-35755.jpg'), // Replace with your image asset
              ),
              const SizedBox(height: 20),
              Text(
                client.fName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'احلي مسا عالناس الكويسه',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add your action here
                    },
                    child: const Text('المزيد'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add your action here
                    },
                    child: const Text('رسالة'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 245, 235, 235),
                ),
                margin: const EdgeInsets.all(16.0),
                child: const Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      ' الطلبات المنشوره',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: 3,
              //   itemBuilder: (context, index) {
              //     return const PostCard();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
