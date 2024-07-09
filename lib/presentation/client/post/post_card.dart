import 'package:flutter/material.dart';
import 'package:herafy/data/model/order.dart';

class PostCard extends StatelessWidget {
  final Order order;
  const PostCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'وصف الخدمة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              order.description,
              style: const TextStyle(fontSize: 14),
            ),
            const Divider(height: 20, thickness: 1),
            Row(
              children: [
                const Icon(Icons.work),
                const SizedBox(width: 8),
                Text(order.speciality, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            // Row(
            //   children: [
            //     const Icon(Icons.monetization_on),
            //     const SizedBox(width: 8),
            //     Text(proposedPrice, style: const TextStyle(fontSize: 16)),
            //   ],
            // ),
            // const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Text(order.location.toString(),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 8),
                Text('${order.proposals.length} أشخاص قدموا على هذه الخدمة',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 20),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Add your application logic here
            //       print('تم التقديم على الخدمة');
            //     },
            //     child: const Text('قدّم الآن', style: TextStyle(fontSize: 16)),
            //   ),
            // ),
          ],
        ),
      ),
      //  Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'وصف الخدمة',
      //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 10),
      //       Text(
      //         serviceDescription,
      //         style: TextStyle(fontSize: 16),
      //       ),
      //       Divider(height: 30, thickness: 2),
      //       ListTile(
      //         leading: Icon(Icons.work),
      //         title:
      //             Text(requiredSpecialization, style: TextStyle(fontSize: 18)),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.monetization_on),
      //         title: Text(proposedPrice, style: TextStyle(fontSize: 18)),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.location_on),
      //         title: Text(nearestLocation, style: TextStyle(fontSize: 18)),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.people),
      //         title: Text('$applicantsCount أشخاص قدموا على هذه الخدمة',
      //             style: TextStyle(fontSize: 18)),
      //       ),
      //       SizedBox(height: 20),
      //       Center(
      //         child: ElevatedButton(
      //           onPressed: () {
      //             // Add your application logic here
      //             print('تم التقديم على الخدمة');
      //           },
      //           child: Text('قدّم الآن', style: TextStyle(fontSize: 18)),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
