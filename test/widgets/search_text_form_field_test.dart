import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_multiselect_dropdown/widgets/search_text_form_field.dart';

void main() {
  testWidgets('SearchTextFormField renders correctly', (tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SearchTextFormField(
              controller: TextEditingController(),
              hintText: 'Test Hint',
              onChanged: (String value) {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SearchTextFormField), findsOneWidget);
  });
}
