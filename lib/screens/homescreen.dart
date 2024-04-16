import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/controllers/student_controller.dart';
import 'package:getx_project/data_model/student_model.dart';
import 'package:getx_project/screens/profile.dart';
import 'package:getx_project/screens/register.dart';

class HomeScreen extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.check = true;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
              () => Resgister(
                  controller: controller,
                  student: Student(
                      name: '', age: '', department: '', image: '', place: '')),
              arguments: 'Register');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: GetBuilder<StudentController>(
          init: StudentController(),
          builder: (controller) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      controller.search(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: controller.isloading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.students.isEmpty
                            ? const Center(
                                child: Text('No students found'),
                              )
                            : ListView.builder(
                                itemCount: controller.students.length,
                                itemBuilder: (context, index) {
                                  var student = controller.students[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            31, 7, 255, 172),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => Profile(
                                            controller: controller,
                                            student: student));
                                      },
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                    () => Resgister(
                                                        student: student,
                                                        controller: controller),
                                                    arguments: 'edit');
                                              },
                                              child: const Icon(Icons.edit)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                Get.defaultDialog(
                                                    title: 'Delete',
                                                    middleText: 'are you sure?',
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            controller
                                                                .delete(student)
                                                                .then((value) {
                                                              Get.back();
                                                              Get.back();
                                                              Get.snackbar(
                                                                  'Deleted succesfully',
                                                                  '',
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                            });
                                                          },
                                                          child: const Text(
                                                              'confirm')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              'cancel')),
                                                    ]);
                                              },
                                              child: const Icon(Icons.delete))
                                        ],
                                      ),
                                      title: Text(student.name),
                                      leading: student.image == ''
                                          ? const CircleAvatar(
                                              child: Icon(Icons.person_2),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: FileImage(
                                                  File(student.image)),
                                            ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
