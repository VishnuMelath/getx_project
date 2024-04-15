import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String image;
  @HiveField(3)
  String department;
  @HiveField(4)
  String place;
  Student(
      {required this.name,
      required this.age,
      required this.department,
      required this.image,
      required this.place});
}
