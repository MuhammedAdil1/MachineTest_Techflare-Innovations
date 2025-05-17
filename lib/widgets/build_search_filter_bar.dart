import 'package:flutter/material.dart';

class BuildSearchFilterBar extends StatefulWidget {
  final Function({
  String? search,
  String? location,
  String? company,
  }) onFilterChanged;

  const BuildSearchFilterBar({super.key, required this.onFilterChanged});

  @override
  State<BuildSearchFilterBar> createState() => _BuildSearchFilterBarState();
}

class _BuildSearchFilterBarState extends State<BuildSearchFilterBar> {
  final _searchController = TextEditingController();
  final _locationController = TextEditingController();
  final _companyController = TextEditingController();

  final _primaryColor = Colors.deepPurple.shade700;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Card(
        color: Colors.grey[100],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //
              TextField(
                controller: _searchController,
                onChanged: (value) => widget.onFilterChanged(search: value),
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Search Job Title',
                  labelStyle: TextStyle(
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: _primaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor.withOpacity(0.4), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  fillColor: Colors.white,
                  filled: true,
                ),
                cursorColor: _primaryColor,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _locationController,
                onChanged: (value) => widget.onFilterChanged(location: value),
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Filter by Location',
                  labelStyle: TextStyle(
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.location_on, color: _primaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor.withOpacity(0.4), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  fillColor: Colors.white,
                  filled: true,
                ),
                cursorColor: _primaryColor,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _companyController,
                onChanged: (value) => widget.onFilterChanged(company: value),
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: 'Filter by Company(e.g: Upstart)',
                  labelStyle: TextStyle(
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.category, color: _primaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor.withOpacity(0.4), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  fillColor: Colors.white,
                  filled: true,
                ),
                cursorColor: _primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
