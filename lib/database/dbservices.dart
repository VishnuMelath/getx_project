import 'package:getx_project/data_model/student_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentServices {
  Future insert(Student student) async {
    var box = await Hive.openBox('student');
    await box.add(student);
    await box.close();
  }

  Future delete(int key) async {
    var box = await Hive.openBox('student');
    await box.delete(key);
    await box.close();
  }

  Future updateStudent(Student student, int key) async {
    var box = await Hive.openBox('student');
    await box.put(key, student);
    await box.close();
  }

  Future<List<Student>> getAllStudent() async {
    var box = await Hive.openBox<Student>('student');
    var list = box.values.toList();
    await box.close();
    return list;
  }

  Future<List<Student>> search(String searchValue) async {
    var box = await Hive.openBox<Student>('student');
    var list = box.values.toList();
    List<Student> searchResults = list.where((item) {
      return item.name.toLowerCase() == searchValue.toLowerCase() || item.name.contains(searchValue);
    }).toList();
    await box.close();
    return searchResults;
  }
}
