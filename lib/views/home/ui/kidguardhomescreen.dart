import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:graduation/views/home/ui/productselectionpage.dart';
import '../../health/ui/health_record_screen.dart';
import '../../notifications_screen.dart';
import '../../welcome_screen.dart';
import '../../location_screen.dart';
import '../../budget_setting_screen.dart';

class KidGuardHomeScreen extends StatelessWidget {
  const KidGuardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.handshake, size: 36, color: Colors.black54),
                    SizedBox(width: 8),
                    Text(
                      "KidGuard",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.black54),
                  iconSize: 35,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const WelcomeScreen(),
                        transitionsBuilder:
                            (_, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Hero(
            tag: 'kidguard_logo',
            child: Image.asset(
              'assets/Screenshot 2025-02-02 084951.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    animatedMenuItem(
                      context,
                      "Notifications",
                      Icons.notifications,
                      "You have new alerts",
                      NotificationsScreen(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    animatedMenuItem(
                      context,
                      "Health Records",
                      Icons.favorite,
                      "Your medical history at a glance",
                      HealthRecordScreen(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    animatedMenuItem(
                      context,
                      "Location Tracking",
                      Icons.location_on,
                      "Track your location",
                      LocationScreen(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    animatedMenuItem(
                      context,
                      "Product Selected",
                      Icons.check_box,
                      "Restrict products for your child",
                      ProductSelectionPage(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    animatedMenuItem(
                      context,
                      "Set Budget",
                      Icons.account_balance_wallet,
                      "Manage school spending",
                      BudgetSettingScreen(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xFF757575),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "Location",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Health",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: "Budget",
            ),
          ],
          onTap: (index) {
            Widget? page;
            switch (index) {
              case 1:
                page = NotificationsScreen();
                break;
              case 2:
                page = LocationScreen();
                break;
              case 3:
                page = HealthRecordScreen();
                break;
              case 4:
                page = ProductSelectionPage();
                break;
              case 5:
                page = BudgetSettingScreen();
                break;
            }
            if (page != null) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => page!,
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // تعديل دالة animatedMenuItem لتأخذ 5 معطيات كما في الكود
  Widget animatedMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    Widget page,
  ) {
    return OpenContainer(
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      closedColor: Colors.white,
      openColor: Colors.white,
      openBuilder: (_, __) => page,
      closedBuilder: (_, openContainer) => ListTile(
        onTap: openContainer,
        leading: Icon(icon, size: 40, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
      ),
    );
  }
}
