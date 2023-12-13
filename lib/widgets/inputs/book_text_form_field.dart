import 'package:flutter/material.dart';

class BookTextFormField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final void Function(String?)? onSaved; // Update the type here
  final String initialValue;

  const BookTextFormField({
    Key? key, // Use 'key' instead of 'super.key'
    required this.labelText,
    required this.errorText,
    required this.onSaved,
    required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: const TextStyle(
          fontSize: 15.0,
          height: 0.9,
        ),
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Adjust the color as needed
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return errorText;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
