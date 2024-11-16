import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Booking"),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          BestBookingCard(
            imageUrl: 'assets/images/Picture3.png',
            profileUrl: 'assets/images/rafi.jpeg',
            name: 'Miss Zachary Will',
            role: 'Beautician',
            description:
                'Occaecati aut nam beatae quo non deserunt consequatur.',
            rating: 4.9,
          ),
          SizedBox(height: 16.0),
          BestBookingCard(
            imageUrl: 'assets/images/Picture3.png',
            profileUrl: 'assets/images/rafi.jpeg',
            name: 'Miss Zachary Will',
            role: 'Beautician',
            description:
                'Occaecati aut nam beatae quo non deserunt consequatur.',
            rating: 4.9,
          ),
        ],
      ),
    );
  }
}

class BestBookingCard extends StatelessWidget {
  final String imageUrl;
  final String profileUrl;
  final String name;
  final String role;
  final String description;
  final double rating;

  const BestBookingCard({
    required this.imageUrl,
    required this.profileUrl,
    required this.name,
    required this.role,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profileUrl),
                  radius: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        role,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
