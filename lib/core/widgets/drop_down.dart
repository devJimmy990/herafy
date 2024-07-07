import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final String value;
  final bool isArabic;
  final String? label;
  final List<String> list;
  final void Function(String?)? onChanged;
  const CustomDropDownMenu({
    super.key,
    this.label,
    required this.list,
    required this.value,
    this.isArabic = false,
    required this.onChanged,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: widget.value,
                  isExpanded: true,
                  alignment: Alignment.center,
                  onChanged: widget.onChanged,
                  borderRadius: BorderRadius.circular(18),
                  items:
                      widget.list.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Center(
                          child: Text(
                        val,
                        textAlign: TextAlign.center,
                      )),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          widget.label == null
              ? const SizedBox()
              : Positioned.fill(
                  top: -9,
                  left: widget.isArabic ? 0 : 10,
                  right: widget.isArabic ? 10 : 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Align(
                      alignment: widget.isArabic
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          color: Colors.white,
                          child: Text(
                            widget.label ?? "Sdds",
                            textDirection: widget.isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  )),
        ],
      ),
    );
  }
}
