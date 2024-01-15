import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchBar extends StatefulWidget {
  final void Function(String) onSearch;

  CustomSearchBar({required this.onSearch});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    widget.onSearch(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: Theme.of(context).textTheme.bodyMedium!,
      decoration: InputDecoration(
        labelText: 'Produkt suchen',
        hintText: 'Produktnamen hier eingeben',
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            _performSearch();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
        ),
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        _performSearch();
      },
    );
  }
}
