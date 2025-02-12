import 'package:flutter/material.dart';

Widget buildEmailField({
  bool isArabic = false,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "البريد الالكتروني",
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

Widget buildNumberField({
  bool isArabic = false,
  bool isCenter = false,
  required String label,
  required IconData icon,
  required TextEditingController controller,
  String? Function(String?)? validator,
}) {
  return Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: TextFormField(
      validator: validator,
      controller: controller,
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

Widget buildPasswordField({
  required String label,
  bool isArabic = false,
  bool showPassword = false,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required void Function()? changePasswordVisibility,
}) {
  return Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: TextFormField(
      obscureText: !showPassword,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: changePasswordVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

Widget buildTextField({
  bool isArabic = false,
  required String label,
  IconData? icon,
  required TextEditingController controller,
  required String? Function(String?) validator,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

Widget buildMultiLineTextField({
  int maxLines = 3,
  bool isArabic = false,
  FocusNode? focusNode,
  required String hint,
  required String label,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: TextFormField(
      minLines: 1,
      maxLines: maxLines,
      focusNode: focusNode,
      validator: validator,
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
