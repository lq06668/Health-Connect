import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/hospitals.dart';
import 'package:flutter_application_1/screens/admin_login.dart';
import 'package:flutter_application_1/screens/doctor_search.dart';

class HospitalWidget extends StatelessWidget {
  final HospitalItem item;
  final String userid;
  final String username;

  const HospitalWidget({Key? key, required this.item, required this.userid, required this.username})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("${item.name} pressed");
          Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return Doctor_Search(hospitalName: item.name, userId: userid, username: username,);
                  }));

        },
       
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              "${item.location}",
              style: TextStyle(
                color: Color(0xFF02411A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
