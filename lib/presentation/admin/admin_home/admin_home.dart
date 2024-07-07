import 'package:flutter/material.dart';
import '../peole_screen/accept_account_screen.dart';
import '../profits_screen/profits_screen.dart';
import '../reviews_screen/reviews_screen.dart';
import '../statistics_screen/statistics_screen.dart';
import 'grid_item.dart';
import 'grid_model.dart';
class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
  @override
  Widget build(BuildContext context) {
    const List<GridModel> grid = [
      GridModel(
        image: "assets/images/comments.png",
        body: "التعليقات",
      ),
      GridModel(
        image: "assets/images/people.png",
        body: "المستخدمين",
      ),
       GridModel(
        image: "assets/images/money.png",
        body: "الارباح",
      ),
      GridModel(
        image: "assets/images/statistics.png",
        body: "الاحصائيات",
      ),
    ];
 const List<Widget> pages = [
    AcceptAccountScreen(),
    ProfitsScreen(),
    StatisticsScreen(),
    ReviewsScreen(),
  ];
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 215, 244, 242),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Expanded(
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.75,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    children: List.generate(
                      grid.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => pages[index]));
                        },
                        child: gridItem(
                          grid[index],
                        ),
                      ),
                    ),
                  ),
                ),
                  const SizedBox(
                      height: 100,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



