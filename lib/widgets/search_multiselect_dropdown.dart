import 'package:flutter/material.dart';
import 'package:search_multiselect_dropdown/styles/color_catalog.dart';
import 'package:search_multiselect_dropdown/styles/style_catalog.dart';
import 'package:search_multiselect_dropdown/widgets/search_text_form_field.dart';

class SearchMultiselectDropdown extends StatefulWidget {
  const SearchMultiselectDropdown({
    super.key,
    required this.title,
    required this.dropDownOptions,
  });
  final String title;
  final List<dynamic>? dropDownOptions;

  @override
  State<SearchMultiselectDropdown> createState() =>
      _SearchMultiselectDropdownState();
}

class _SearchMultiselectDropdownState extends State<SearchMultiselectDropdown> {
  bool _isTapped = false;
  List<dynamic> _filteredList = [];
  final List<dynamic> _selectedOptionsList = [];
  late TextEditingController _controllerSearch;
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();
  final _layerLink = LayerLink();
  final _scrollController = ScrollController();

  @override
  initState() {
    _filteredList = widget.dropDownOptions!;
    _controllerSearch = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                      child: Text(
                        widget.title,
                        style: darkSimpleTextStyle,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorMediumGrey,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: _buildDropDownWidget(),
                    ),
                    _isTapped ? _buildExpandedDropDown() : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropDownWidget() {
    return InkWell(
      key: const ValueKey('dropDownWidget'),
      onTap: () => setState(() {
        _isTapped = !_isTapped;
        if (_isTapped) {
          _overlayPortalController.toggle();
        }
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _getSelectedOptionsText(),
                overflow: TextOverflow.ellipsis,
                style: darkSimpleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: !_isTapped
                ? const Icon(
                    Icons.expand_more_rounded,
                  )
                : const Icon(
                    Icons.expand_less_rounded,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedDropDown() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) => CompositedTransformFollower(
          link: _layerLink,
          targetAnchor: Alignment.bottomLeft,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              width: 500,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: colorMediumGrey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: _isAllOptionsSelected()
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _clearSelectedOptions();
                                  });
                                },
                                icon: const Icon(
                                  Icons.check_box_outlined,
                                  color: colorThemeApp,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectAllOptions();
                                  });
                                },
                                icon: const Icon(
                                  Icons.check_box_outline_blank,
                                  color: colorGrey,
                                ),
                              ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 8.0,
                          ),
                          child: SearchTextFormField(
                            controller: _controllerSearch,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty || value == "") {
                                  _filteredList = widget.dropDownOptions!;
                                } else {
                                  setState(() {
                                    _searchTerm(value);
                                  });
                                }
                              });
                            },
                            hintText: 'Search by user name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20.0,
                          top: 8.0,
                        ),
                        child: SizedBox(
                          width: 20,
                          child: IconButton(
                            icon: const Icon(Icons.clear),
                            hoverColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                _controllerSearch.clear();
                                _searchTerm('');
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _filteredList.length,
                        itemBuilder: (context, index) {
                          return _buildDropDownOptionList(
                              _getOptionDescription(_filteredList[index]),
                              _isOptionSelected(_filteredList[index]),
                              index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownOptionList(
      String name, bool isOptionSelected, int index) {
    return ListTile(
      leading: isOptionSelected
          ? const Icon(
              Icons.check_box_outlined,
              color: colorThemeApp,
            )
          : const Icon(
              Icons.check_box_outline_blank,
              color: colorGrey,
            ),
      title: Text(
        name,
        style: darkSimpleTextStyle,
      ),
      onTap: () {
        setState(() {
          if (!isOptionSelected) {
            _selectedOptionsList.add(_filteredList[index]);
          } else {
            _selectedOptionsList
                .removeWhere((element) => element == _filteredList[index]);
          }
        });
      },
    );
  }

  _getOptionDescription(dynamic option) {
    return option.name;
  }

  _getSelectedOptionsText() {
    String selectedOptionsText = "";

    if (_selectedOptionsList.isNotEmpty) {
      for (var element in _selectedOptionsList) {
        selectedOptionsText += "${element.name}, ";
      }
    }

    if (_selectedOptionsList.length > 3) {
      return "${_selectedOptionsList.length} registros selecionados";
    }

    return selectedOptionsText;
  }

  _isAllOptionsSelected() {
    List<dynamic> selectedOptions = [];

    for (var element in _filteredList) {
      if (_selectedOptionsList.contains(element)) {
        selectedOptions.add(element);
      }
    }

    return _filteredList.isNotEmpty &&
        _filteredList.length == selectedOptions.length;
  }

  _clearSelectedOptions() {
    _selectedOptionsList.clear();
  }

  _selectAllOptions() {
    for (var element in _filteredList) {
      int index = _selectedOptionsList.indexWhere((e) => e == element);

      if (index < 0) {
        _selectedOptionsList.add(element);
      }
    }
  }

  _searchTerm(String term) {
    if (term.isEmpty) {
      _filteredList = widget.dropDownOptions!;
    } else {
      _filteredList = widget.dropDownOptions!.where((user) {
        return (user.name.toLowerCase().contains(term.toLowerCase()));
      }).toList();
    }
  }

  _isOptionSelected(dynamic option) {
    int index;

    index = _selectedOptionsList.indexWhere((user) => user.name == option.name);

    return index >= 0;
  }
}
