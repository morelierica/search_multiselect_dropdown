import 'package:flutter/material.dart';
import 'package:search_multiselect_dropdown/styles/color_catalog.dart';
import 'package:search_multiselect_dropdown/styles/style_catalog.dart';

class SearchTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final String? hintText;

  const SearchTextFormField({
    super.key,
    this.onChanged,
    this.onTap,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFullHd = MediaQuery.of(context).size.width >= 1920;
    return SizedBox(
      height: isFullHd ? 50 : 40,
      child: TextFormField(
        controller: controller,
        style: darkSimpleTextStyle,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search,
            color: colorDarkGrey,
          ),
          hintText: hintText,
          focusColor: colorGrey,
          hoverColor: Colors.white,
          fillColor: colorDisabled,
          contentPadding: const EdgeInsets.only(
            left: 8,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: colorGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(isFullHd ? 8 : 6)),
            borderSide: const BorderSide(color: colorGrey),
          ),
        ),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
