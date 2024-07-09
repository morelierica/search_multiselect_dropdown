import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_multiselect_dropdown/utils/search_multiselect_dropdown_utils.dart';
import 'package:search_multiselect_dropdown/widgets/search_multiselect_dropdown.dart';

void main() {
  group('_buildDropDownWidget', () {
    testWidgets('Should have a dropdown widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Finding DropDownWidget by its key
      Finder dropDownWidget = find.byKey(const ValueKey('dropDownWidget'));

      expect(dropDownWidget, findsOneWidget);
    });

    testWidgets('Should expand the dropdown widget on tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      expect(find.byType(CompositedTransformFollower), findsOneWidget);
    });
  });

  group('_buildExpandedDropDown', () {
    testWidgets(
        'Should select all options on tap the first check_box_outline_blank icon',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Tapping to select all options
      await tester.tap(find.byIcon(Icons.check_box_outline_blank).first);
      await tester.pump();

      expect(find.byIcon(Icons.check_box_outlined), findsWidgets);
      expect(find.byIcon(Icons.check_box_outline_blank), findsNothing);
    });

    testWidgets(
        'Should deselect all options on tap the first check_box_outlined icon',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Tapping to select all options
      await tester.tap(find.byIcon(Icons.check_box_outline_blank).first);
      await tester.pump();

      // Tapping to deselect all options
      await tester.tap(find.byIcon(Icons.check_box_outlined).first);
      await tester.pump();

      expect(find.byIcon(Icons.check_box_outline_blank), findsWidgets);
      expect(find.byIcon(Icons.check_box_outlined), findsNothing);
    });

    testWidgets('Should search a user by name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Entering a user name into TextField
      await tester.enterText(find.byType(TextField), userList.first.name);
      await tester.pump();

      expect(find.text(userList.first.name), findsWidgets);
      expect(find.text(userList.last.name), findsNothing);
    });

    testWidgets('Should search a empty string to reset the search',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Entering a user name into TextField
      await tester.enterText(find.byType(TextField), userList.first.name);
      await tester.pump();

      // Entering an empty text into TextField
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      expect(find.text('Search by user name'), findsOneWidget);
    });

    testWidgets('Should reset the search on tap the clear button',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Entering a user name into TextField
      await tester.enterText(find.byType(TextField), userList.first.name);
      await tester.pump();

      // Tapping clear button
      await tester.tap(find.byIcon(Icons.clear).first);
      await tester.pump();

      expect(find.text('Search by user name'), findsOneWidget);
    });
  });

  group('_buildDropDownOptionList', () {
    testWidgets(
        'Should select one option of the list when this option is not selected',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Selecting list first option
      await tester.tap(find.byType(ListTile).first);
      await tester.pump();

      expect(find.byIcon(Icons.check_box_outlined), findsOneWidget);
    });

    testWidgets(
        'Should deselect one option of the list when this option is selected',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SearchMultiselectDropdown(
                title: 'Users',
                dropDownOptions: userList,
              ),
            ),
          ),
        ),
      );

      // Expanding DropDownWidget
      await tester.tap(find.byKey(const ValueKey('dropDownWidget')));
      await tester.pump();

      // Selecting list first option
      await tester.tap(find.byType(ListTile).first);
      await tester.pump();

      // Deselecting list first option
      await tester.tap(find.byType(ListTile).first);
      await tester.pump();

      expect(find.byIcon(Icons.check_box_outline_blank), findsWidgets);
      expect(find.byIcon(Icons.check_box_outlined), findsNothing);
    });
  });
}
