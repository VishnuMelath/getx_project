import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/controllers/student_controller.dart';
import 'package:getx_project/data_model/student_model.dart';
import 'package:getx_project/screens/register.dart';

class HomeScreen extends StatelessWidget {
  final StudentController controller=Get.put(StudentController());
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(
            () => Resgister(
              controller: controller,
                student: Student(
                    name: '', age: '', department: '', image: '', place: '')),
            arguments: '');
      }),
      appBar: AppBar(),
      body: GetBuilder<StudentController>(
          init: StudentController(),
          builder: (controller) {
            return Container(
              child: controller.isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.students.isEmpty
                      ? const Center(
                          child: Text('empty'),
                        )
                      : ListView.builder(
                          itemCount: controller.students.length,
                          itemBuilder: (context, index) {
                            return  Text(controller.students[index].name);
                          },
                        ),
            );
          }),
    );
  }
}
