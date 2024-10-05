import 'package:counter_application/main/screens/provider/home_page_provider.dart';
import 'package:counter_application/utility/constants.dart';
import 'package:counter_application/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Application"),
        centerTitle: true,
        backgroundColor: primaryColor.withOpacity(0.8),
        foregroundColor: Colors.white70,
      ),
      backgroundColor: bgColor,
      drawer: Drawer(
        backgroundColor: bgColor,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                // Fetching username from provider
                child: Consumer<HomePageProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.userName ?? 'User Name',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Calling signOut from provider
            DrawerListTile(
              title: "Logout",
              icon: Icons.logout_outlined,
              press: () {
                context.homePageProvider.signOut();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Fetching counter value from provider
              Consumer<HomePageProvider>(
                builder: (context, value, child) {
                  return Text(
                    'Current Value: ${value.value}',
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  );
                },
              ),
              const SizedBox(height: defaultPadding * 3),
              // Increment function from provider
              ElevatedButton(
                onPressed: () {
                  context.homePageProvider.incrementValue();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: const Size(250, 45),
                ),
                child: const Text(
                  'Increment',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 10,
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(color: Colors.white54)),
    );
  }
}
