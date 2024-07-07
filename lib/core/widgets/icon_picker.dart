import 'package:flutter/material.dart';

class IconPicker extends StatefulWidget {
  final String label;
  final bool isArabic;
  final IconData icon;
  final bool isCenter;
  final double iconSize;
  final Future<void> Function() onPressed;
  final TextEditingController controller;
  final String? Function(String?) validator;
  const IconPicker({
    super.key,
    required this.icon,
    this.iconSize = 20,
    required this.label,
    this.isArabic = false,
    this.isCenter = false,
    required this.validator,
    required this.onPressed,
    required this.controller,
  });

  @override
  State<IconPicker> createState() => IconPickerState();
}

class IconPickerState extends State<IconPicker> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Directionality(
            textDirection:
                widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              // readOnly: true,
              textAlign: widget.isCenter ? TextAlign.center : TextAlign.start,
              decoration: InputDecoration(
                labelText: widget.label,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                suffixIcon: IconButton(
                  icon: Icon(
                    widget.icon,
                    size: widget.iconSize,
                  ),
                  onPressed: () {
                    try {
                      setState(() => isLoading = true);
                      widget.onPressed();
                    } catch (e) {
                      debugPrint(e.toString());
                    } finally {
                      setState(() => isLoading = false);
                    }
                  },
                ),
              ),
            ),
          );
  }
}
