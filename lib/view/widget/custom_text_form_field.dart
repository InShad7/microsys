import 'package:flutter/material.dart';
import 'package:microsys/controller/login_controller/login_controller.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon = Icons.abc,
    this.isPrefixIcon = true,
    this.borderRadius = 6,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    // this.maxLength = ,
    this.validator,
    this.obsecureText = false,
    required this.controller,
  });

  final String hintText;
  final double borderRadius;
  final bool isPrefixIcon;
  final IconData prefixIcon;
  final int maxLines;
  final TextInputType keyboardType;
  // final int maxLength;
  final bool obsecureText;
  final TextEditingController controller;

  final validator;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginController>(context);
    return TextFormField(
      controller: controller,
      obscureText: obsecureText ? loginProvider.isPassView : false,
      decoration: InputDecoration(
        fillColor: grey200,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: textClrGrey,
          fontSize: 14,
        ),
        prefixIcon: isPrefixIcon
            ? Icon(
                prefixIcon,
                color: textClrGrey,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        counterText: '',
        suffixIcon: obsecureText
            ? GestureDetector(
                onTap: () {
                  loginProvider.togglePassView();
                },
                child: Icon(
                  loginProvider.isPassView
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: blue2,
                ),
              )
            : null,
      ),
      // maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
