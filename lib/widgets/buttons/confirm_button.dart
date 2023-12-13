import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double height;

  const ConfirmButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary, // Use backgroundColor
          foregroundColor: Colors.white.withOpacity(0.9), // Use foregroundColor
        ),
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
