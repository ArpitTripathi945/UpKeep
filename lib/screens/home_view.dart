import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:upkeep/User_Analytics.dart';
import 'package:upkeep/screens/add_expense_screen.dart';
import 'package:upkeep/screens/expense_view.dart';
import 'package:upkeep/screens/search_view.dart';
import 'package:upkeep/screens/user_profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  final List<Widget> screens = [
    ExpenseView(),
    UserProfile(),
    SearchView(),
    UserAnalytics()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ExpenseView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 17, 32),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddExpenseScreen(),
                    )));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color.fromARGB(255, 2, 4, 18),
        notchMargin: 10,
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 90,
                      onPressed: () {
                        setState(() {
                          currentScreen = ExpenseView();
                          currentIndex = 0;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = UserProfile();
                          currentIndex = 1;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: currentIndex == 1
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                          ]),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = SearchView();
                          currentIndex = 2;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: currentIndex == 2
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 90,
                      onPressed: () {
                        setState(() {
                          currentScreen = UserAnalytics();
                          currentIndex = 3;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bar_chart_rounded,
                              color: currentIndex == 3
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
