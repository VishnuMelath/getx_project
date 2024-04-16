import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/controllers/student_controller.dart';
import 'package:getx_project/data_model/student_model.dart';
import 'package:getx_project/screens/register.dart';

class Profile extends StatelessWidget {
  final StudentController controller;
  final Student student;
  const Profile({super.key, required this.student, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  student.image == ''
                      ? const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person_2),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(student.image)),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    student.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(student.age),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(student.department),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(student.place),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: () {
                        Get.off(()=>Resgister(student: student, controller: controller),arguments: 'edit');

                      }, child: const Text('edit')),
                      TextButton(
                          onPressed: () {
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
                                          Get.snackbar('Deleted succesfully', '',snackPosition: SnackPosition.BOTTOM);
                                        });
                                      },
                                      child: const Text('confirm')),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('cancel')),
                                ]);
                          },
                          child: const Text('delete'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
