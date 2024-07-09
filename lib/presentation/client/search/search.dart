import 'package:flutter/material.dart';
import 'package:herafy/core/widgets/drop_down.dart';
import 'package:herafy/data/demo_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late String speciality = "سباك";
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        _isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 16.0, left: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 300),
                width: _isFocused ? double.infinity : 200.0,
                child: TextFormField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'ابحث...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              if (_isFocused) ...[
                const SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'الموقع',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        items: <String>['القاهره', 'اسكندريه', 'كفر الشيخ']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomDropDownMenu(
                        isArabic: true,
                        value: speciality,
                        label: "إختر التخصص",
                        list: technicainSpecialties,
                        onChanged: (newVal) =>
                            setState(() => speciality = newVal!),
                      ),
                    ),
                  ],
                ),
              ],
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TechnicianCard();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
