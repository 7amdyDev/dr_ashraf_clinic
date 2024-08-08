// import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
// import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OnlineReservationDb {
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   var controller = Get.put(ClinicController());
// // create data

//   void createData(OnlineReservModel data) {
//     database.databaseURL =
//         'https://ashrafyehiaclinic-default-rtdb.firebaseio.com/';
//     final DatabaseReference reference = database.ref().child('Appointment');

//     final newAppointRef =
//         reference.push(); // Create a new reference for a new appointment
//     newAppointRef.set({
//       'name': data.name,
//       'date': data.dateTime,
//       'mobile': data.mobile,
//     }).then((_) {
//       debugPrint('User added successfully');
//     }).catchError((error) {
//       debugPrint('Error adding user: $error');
//     });
//   }

//   void getData() async {
//     controller.onlineReservData.clear();

//     database.databaseURL =
//         'https://ashrafyehiaclinic-default-rtdb.firebaseio.com/';
//     final DatabaseReference reference = database.ref().child('Appointment');
//     final snapshot = await reference.get();
//     if (snapshot.exists) {
//       var result = snapshot.value as Map?;

//       result?.forEach(
//         (key, value) {
//           controller.onlineReservData.add(OnlineReservModel(
//               id: key,
//               name: value["name"],
//               mobile: value["mobile"],
//               dateTime: value["date"]));
//         },
//       );
//     } else {
//       print('No data available.');
//     }
//   }

//   void readData() {
//     controller.onlineReservData.clear();

//     database.databaseURL =
//         'https://ashrafyehiaclinic-default-rtdb.firebaseio.com/';
//     final DatabaseReference reference = database.ref().child('Appointment');

//     reference.onValue.listen((event) {
//       final data = event.snapshot.value as Map?;

//       if (data != null) {
//         data.forEach(
//           (key, value) {
//             controller.onlineReservData.add(OnlineReservModel(
//                 id: key,
//                 name: value["name"],
//                 mobile: value["mobile"],
//                 dateTime: value["date"]));
//           },
//         );
//       }
//     });
//   }

//   void deleteData(String appointId) {
//     database.databaseURL =
//         'https://ashrafyehiaclinic-default-rtdb.firebaseio.com/';
//     final DatabaseReference reference =
//         database.ref().child('Appointment/$appointId');
//     reference.remove().then((_) {
//       debugPrint('User removed successfully');
//     }).catchError((error) {
//       debugPrint('Error removing user: $error');
//     });
//   }
//   // void updateData(String appointId) {
//   //   reference.update({
//   //     'email': 'john.doe@example.com',
//   //   }).then((_) {
//   //     print('User updated successfully');
//   //   }).catchError((error) {
//   //     print('Error updating user: $error');
//   //   });
//   // }
// }
