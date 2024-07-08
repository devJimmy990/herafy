import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final String serviceDescription =
        "نحن نبحث عن مصمم جرافيك محترف لتصميم شعار جديد لشركتنا.";
    final String requiredSpecialization = "مصمم جرافيك";
    final String proposedPrice = "1000 جنيه مصري";
    final String nearestLocation = "القاهرة";
    final int applicantsCount = 10;
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
            Text(
              'وصف الخدمة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              serviceDescription,
              style: TextStyle(fontSize: 14),
            ),
            Divider(height: 20, thickness: 1),
            Row(
              children: [
                Icon(Icons.work),
                SizedBox(width: 8),
                Text(requiredSpecialization, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.monetization_on),
                SizedBox(width: 8),
                Text(proposedPrice, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 8),
                Text(nearestLocation, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.people),
                SizedBox(width: 8),
                Text('$applicantsCount أشخاص قدموا على هذه الخدمة',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your application logic here
                  print('تم التقديم على الخدمة');
                },
                child: Text('قدّم الآن', style: TextStyle(fontSize: 16)),
              ),
            ),
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
