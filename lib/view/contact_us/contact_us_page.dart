import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF3FF),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'Connect with Us!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Feel free to reach out to us for further information!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ContactSection(
              phoneNumber: '01270777375',
              timings: 'المواعيد من ٨ الي ١١ مساء\nعدا الجمعة',
              address: 'عيادة سموحة ٥٧ ش فيكتور عمانويل أمام زهران مول',
            ),
            SizedBox(height: 16),
            ContactSection(
              phoneNumber: '01157512697 / 034111190',
              timings: 'المواعيد من ٨ الي ١١ مساء\nعدا الجمعة',
              address:
                  'عيادة العجمي أبو يوسف ش إسكندرية مطروح أمام صيدلية المعراج',
            ),
            SizedBox(height: 30),
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/dr_ashraf_yehia.png'), // Replace with the actual image path
                ),
                SizedBox(height: 16),
                Text(
                  'Dr. Ashraf Yehia',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final String phoneNumber;
  final String timings;
  final String address;

  ContactSection({
    required this.phoneNumber,
    required this.timings,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFFE39F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.phone, color: Colors.black),
              SizedBox(width: 10),
              Text(
                phoneNumber,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.black),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  timings,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.black),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
