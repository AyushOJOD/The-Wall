import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  //get year
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();

  String date = dateTime.day.toString();

  //final formated data
  String formatedData = "$date/$month/$year";

  return formatedData;
}
