import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, String>> _notifications = [
    {
      'imageUrl': 'assets/684908.png',
      'title': 'New location update',
      'subtitle': 'Just now',
    },
    {
      'imageUrl': 'assets/3502591.png',
      'title': 'Purchase allowed',
      'subtitle': '2 hours ago',
    },
    {
      'imageUrl': 'assets/1828843.png',
      'title': 'Purchase blocked',
      'subtitle': 'Yesterday',
    },
  ];

  bool _isCleared = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isCleared
                ? const Center(
                    child: Text(
                      "No notifications",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        imageUrl: _notifications[index]['imageUrl']!,
                        title: _notifications[index]['title']!,
                        subtitle: _notifications[index]['subtitle']!,
                      );
                    },
                  ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isCleared = true; // إخفاء الإشعارات عند الضغط
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Clear All", style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const NotificationItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: [
          Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
