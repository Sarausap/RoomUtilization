import 'package:cloud_firestore/cloud_firestore.dart';

class Semester {
  String semester_name;
  Timestamp start_date;
  Timestamp end_date;

  Semester(this.semester_name, this.start_date, this.end_date);

  static Semester fromMap(Map<String, dynamic> map) {
    return Semester(map['semester_name'], map['start_date'], map['end_date']);
  }

  static Future<Semester?> getSemester() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('semester').doc().get();
    if (doc.exists) {
      return Semester.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Future<Semester?> getSemesterbyID(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('semester').doc(id).get();
    if (doc.exists) {
      return Semester.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
