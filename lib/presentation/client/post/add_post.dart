import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final formKey = GlobalKey<FormState>();
  String? selectedSpecialty;
  String? selectedLocation;
  final List<String> specialties = ['تخصص 1', 'تخصص 2', 'تخصص 3'];
  final List<String> locations = ['موقع 1', 'موقع 2', 'موقع 3'];
  TextEditingController descriptionController = TextEditingController();
  Color checkColor = Colors.grey;
  IconData icon = Icons.more_horiz_rounded;

  void validateForm() {
    if (selectedSpecialty != null &&
        selectedLocation != null &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        checkColor = Colors.green;
        icon = Icons.check_circle_outline;
      });
    } else {
      setState(() {
        checkColor = Colors.grey;
        icon = Icons.more_horiz_rounded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "إضافة طلب جديد",
            style: TextStyle(fontSize: 21),
          ),
          centerTitle: true,
          leading: const Icon(Icons.arrow_back_ios_new, size: 25),
          actions: [
            Icon(
              icon,
              color: checkColor,
              size: 25,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value) {
                  validateForm();
                },
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'التفاصيل'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال وصف الطلب';
                  }
                  return null;
                },
                minLines: 1,
                maxLines: 15,
              ),
              DropdownButtonFormField<String>(
                value: selectedSpecialty,
                decoration: InputDecoration(labelText: 'التخصص المطلوب'),
                items: specialties.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSpecialty = newValue;
                  });
                  validateForm();
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار التخصص المطلوب';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                decoration: InputDecoration(labelText: 'الموقع الأقرب'),
                items: locations.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                  validateForm();
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار الموقع الأقرب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Process the form data
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم إضافة الطلب بنجاح')));
                  }
                },
                child: Text('إضافة الطلب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
