import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/controllers/student_controller.dart';
import 'package:getx_project/data_model/student_model.dart';
import 'package:getx_project/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class Resgister extends StatelessWidget {
  final StudentController controller;
  final Student student;
  const Resgister({super.key, required this.student, required this.controller});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller =
        TextEditingController(text: student.name);
    TextEditingController agecontroller =
        TextEditingController(text: student.age);
    TextEditingController departmentcontroller =
        TextEditingController(text: student.department);
    TextEditingController placecontroller =
        TextEditingController(text: student.place);
    GlobalKey<FormState> formkey = GlobalKey();

    var image = student.image.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() => image.string == ''
                    ? GestureDetector(
                        onTap: () async {
                          image.value = await pickImage1();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 192, 192, 192),
                          radius: 60,
                          child: Icon(
                            Icons.person_add_alt,
                            size: 60,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          var temp = await pickImage1();
                          image = temp.obs;
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(
                            File(image.string),
                          ),
                        ),
                      )),
              ),
              CustomTextField(
                hintText: 'name',
                controller: namecontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'age',
                controller: agecontroller,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'place',
                controller: placecontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'department.',
                controller: departmentcontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          if (Get.arguments == 'Register') {
                            await controller.insert(Student(
                                name: namecontroller.text.toLowerCase(),
                                age: agecontroller.text,
                                department: departmentcontroller.text,
                                image: image.string,
                                place: placecontroller.text));
                                 Get.back();
                          Get.snackbar('Inserted succesfully', '',snackPosition: SnackPosition.BOTTOM);
                          } else {
                            int key=student.key;
                            var student1=Student(
                                name: namecontroller.text.toLowerCase(),
                                age: agecontroller.text,
                                department: departmentcontroller.text,
                                image: image.string,
                                place: placecontroller.text);
                            await controller.updateStudent(student1,key);
                             Get.back();
                          Get.snackbar('Updated succesfully', '',snackPosition: SnackPosition.BOTTOM);
                          }

                         
                        }
                      },
                      child: const Text('submit')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> pickImage1() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image != null ? image.path : '';
}
