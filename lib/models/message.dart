// lib/models/message.dart

import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// CRITICAL PART 1: This line tells Dart that a generated file is part of this file.
part 'message.g.dart';

// CRITICAL PART 2: The @HiveType annotation tells the generator to process this class.
@HiveType(typeId: 1) // typeId must be unique for each Hive object type
class Message extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String text;

  @HiveField(2)
  late String senderId;

  @HiveField(3)
  late Timestamp timestamp;

  // Add other fields you'll need for your chat messages here
  @HiveField(4)
  String? type; // e.g., 'text', 'image', 'video'

  @HiveField(5)
  String? fileUrl; // For network files

  @HiveField(6)
  String? localPath; // For offline files

  @HiveField(7)
  String? status; // e.g., 'sending', 'sent', 'failed'

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.type,
    this.fileUrl,
    this.localPath,
    this.status,
  });
}

// CRITICAL PART 3: Hive doesn't know how to store a Firestore Timestamp.
// We need to create a custom adapter to teach it how.
class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  final int typeId = 101; // This ID must also be unique

  @override
  Timestamp read(BinaryReader reader) {
    // We will store the timestamp as milliseconds since epoch
    final millis = reader.readInt();
    return Timestamp.fromMillisecondsSinceEpoch(millis);
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    // When writing, we convert the Timestamp to milliseconds
    writer.writeInt(obj.millisecondsSinceEpoch);
  }
}
