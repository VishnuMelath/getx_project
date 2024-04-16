import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_project/database/dbservices.dart';

import '../data_model/student_model.dart';

class StudentController extends GetxController {
 var students = [];
  bool isloading = true;
  bool check=false;

  @override
  void onInit() {
    super.onInit();
    getAllStudent();
  }
  Future getAllStudent() async {
    students = [...await StudentServices().getAllStudent()];
    isloading = false;
    update();
  }
 
  Future insert(Student student) async {
    await StudentServices().insert(student);
    await getAllStudent();
  }

  Future delete(Student student) async {
    await StudentServices().delete(student.key);
    await getAllStudent();
  }

  Future updateStudent(Student student,int key) async {
    await StudentServices().updateStudent(student,key);
    await getAllStudent();
  }
  Future search(searchValue)async{
    isloading=true;
    students=[...await StudentServices().search(searchValue)];
    isloading=false;
    update();  }
}
