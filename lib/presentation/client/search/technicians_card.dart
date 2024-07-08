import 'package:flutter/material.dart';

class TechnicianCard extends StatelessWidget {
  const TechnicianCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          const CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                "https://img.freepik.com/premium-photo/there-is-cat-that-is-sitting-ledge-chinese-garden-generative-ai_900396-35755.jpg"),
          ),
          const SizedBox(width: 10.0),
          // Name and Specialist
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "محمد أحمد",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "01140239195 ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400, // Making specialist text bold
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'نجار',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
