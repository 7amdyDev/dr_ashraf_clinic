import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFEDF3FF),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
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

  const ContactSection({super.key, 
    required this.phoneNumber,
    required this.timings,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE39F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.black),
              const SizedBox(width: 10),
              Text(
                phoneNumber,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.black),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  timings,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.black),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(
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
