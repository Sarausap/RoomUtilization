import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  int room_id;
  final String room_name;

  Room(this.room_id, this.room_name);

  static Room fromMap(Map<String, dynamic> map) {
    return Room(map['room_id'], map['room_name']);
  }

  static Future<Room?> readRoom(int room_id) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('rooms')
        .doc(room_id.toString())
        .get();
    if (doc.exists) {
      return Room.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}

class Schedule {
  String schedule_id;
  int room_id;
  String weekday;

  Schedule(this.schedule_id, this.room_id, this.weekday);

  static Schedule fromMap(Map<String, dynamic> map) {
    return Schedule(map['schedule_id'], map['room_id'], map['weekday']);
  }

  Map<String, dynamic> toMap() {
    return {
      'schedule_id': schedule_id,
      'room_id': room_id,
      'weekday': weekday,
    };
  }

  static Future<List<Schedule>> readRoom(int room_id) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('schedules')
          .where('room_id', isEqualTo: room_id)
          .get();
      return querySnapshot.docs
          .map((doc) => Schedule.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error reading schedule details: $e");
      return [];
    }
  }
}
