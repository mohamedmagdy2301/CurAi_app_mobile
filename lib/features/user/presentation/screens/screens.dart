import 'package:flutter/material.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Doctors'),
        centerTitle: true,
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notefication Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
