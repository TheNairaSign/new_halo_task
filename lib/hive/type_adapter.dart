import 'package:hive/hive.dart';
import 'package:new_halo_task/models/task_models/task.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0; // Unique identifier for this adapter

  @override
  Task read(BinaryReader reader) {
    final taskName = reader.readString();
    final description = reader.readString();
    final dateMillis = reader.readInt(); // Read the DateTime as milliseconds

    final date = DateTime.fromMillisecondsSinceEpoch(dateMillis);

    return Task(
      taskName: taskName,
      description: description,
      date: date,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.taskName);
    writer.writeString(obj.description);
    writer.writeInt(obj.date.millisecondsSinceEpoch); // Write DateTime as milliseconds
  }
}
