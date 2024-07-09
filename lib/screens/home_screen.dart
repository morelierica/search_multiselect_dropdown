import 'package:flutter/material.dart';
import 'package:search_multiselect_dropdown/utils/search_multiselect_dropdown_utils.dart';
import 'package:search_multiselect_dropdown/widgets/search_multiselect_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchMultiselectDropdown'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchMultiselectDropdown(
                  title: 'Users', dropDownOptions: userList),
            ),
          ],
        ),
      ),
    );
  }
}
