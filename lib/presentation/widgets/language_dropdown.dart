import 'package:flutter/material.dart';
import '../../domain/models/language.dart';

class LanguageDropdown extends StatefulWidget {
  final Language selected;
  final ValueChanged<Language> onChanged;

  const LanguageDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  late ScrollController _scrollController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Language>(
      tooltip: 'Select Language',
      offset: const Offset(0, 48),
      color: const Color(0xFF1E1E2E),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white10),
      ),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.code, size: 16, color: Colors.blueAccent),
            const SizedBox(width: 6),
            Text(
              widget.selected.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.white54,
            ),
          ],
        ),
      ),

      itemBuilder: (context) {
        return [
          PopupMenuItem<Language>(
            enabled: false,
            padding: EdgeInsets.zero,
            child: StatefulBuilder(
              builder: (context, setInnerState) {
                final filtered = kSupportedLanguages
                    .where(
                      (lang) => lang.label.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      ),
                    )
                    .toList();

                return SizedBox(
                  width: 280,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search language...',
                            hintStyle: const TextStyle(
                              color: Colors.white38,
                              fontSize: 13,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 16,
                              color: Colors.white38,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.white38,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      setInnerState(() {});
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white10,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (_) => setInnerState(() {}),
                        ),
                      ),

                      const Divider(color: Colors.white10, height: 1),

                      SizedBox(
                        height: 260,
                        child: filtered.isEmpty
                            ? const Center(
                                child: Text(
                                  'No languages found',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : Scrollbar(
                                controller: _scrollController,
                                thumbVisibility: true,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  primary: false,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  itemCount: filtered.length,
                                  itemBuilder: (context, index) {
                                    final lang = filtered[index];
                                    final isSelected =
                                        widget.selected.key == lang.key;

                                    return InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      hoverColor: Colors.white10,
                                      onTap: () {
                                        _searchController.clear();
                                        Navigator.pop(context);
                                        widget.onChanged(lang);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            AnimatedOpacity(
                                              duration: const Duration(
                                                milliseconds: 150,
                                              ),
                                              opacity: isSelected ? 1 : 0,
                                              child: const Icon(
                                                Icons.check,
                                                size: 14,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              lang.label,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Colors.blueAccent
                                                    : Colors.white70,
                                                fontSize: 13,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ];
      },

      onSelected: (_) {},
    );
  }
}
