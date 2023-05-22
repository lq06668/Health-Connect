import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/doctors.dart';

class DoctorProfilePage extends StatelessWidget {
  final String name;
  final String specialization;
  final String about;
  final String education;
  final String experience;
  final int bad;
  final int good;
  final int medium;
  

  const DoctorProfilePage({
    Key? key,
    required this.name,
    required this.specialization,
    required this.about,
    required this.education,
    required this.experience,
    required this.bad,
    required this.good,
    required this.medium,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children : [
        Container(
          color: Color.fromARGB(255, 195, 233, 214),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SizedBox(width: 100.0),
                  // Spacer(),
                  Text(name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold, fontSize: 25),),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(width: 80.0),
                  // Spacer(),
                  Text('Department:  $specialization',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 22, color: Color.fromARGB(255, 41, 74, 98)),),
                ]
              ),
            ),
            SizedBox(height: 20.0),
            
          ],
        ),
      ),
    Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          SizedBox(height: 15.0),
          Text(
            about,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
          ),
          SizedBox(height: 20.0),
          
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(
            'Education: $education',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),],),
          
          SizedBox(height: 20.0),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(
            'Experience: $experience  years',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
          ),],),
          
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            children: List.generate(1, (index) => Icon(Icons.mood_bad_outlined, size: 50)),
          ),
          Text(
            '$bad Reviews',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Row(
            children: List.generate(1, (index) => Icon(Icons.emoji_emotions_outlined, size: 50)),
          ),
            Text(
            '$good Reviews',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            children: List.generate(1, (index) => Icon(Icons.sentiment_neutral_outlined, size: 50)),
          ),
          Text(
            '$medium Reviews',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ]),
          
          
        ],
      ),
    ),
    
  ],
      ),
    ),
  );
}
}





