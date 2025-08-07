import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:autotruckstore/utils/AppColors.dart';

class SearchFiledHome extends StatefulWidget {
  const SearchFiledHome({super.key});

  @override
  State<SearchFiledHome> createState() => _SearchFiledHomeState();
}

class _SearchFiledHomeState extends State<SearchFiledHome> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double searchFieldWidth = width <= 550 ? 100 : 250;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: searchFieldWidth,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: _isFocused ? Colors.white.withOpacity(0.1) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isFocused ? Colors.white : Colors.white24,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(
                context,
              ).requestFocus(_focusNode); // focus the text field
            },
            child: AnimatedScale(
              scale: _isFocused ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.search,
                color: _isFocused ? Colors.white : Colors.white70,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              cursorWidth: 0.8,
              cursorColor: Colors.white,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.go('/search/${value.trim()}');
                }
              },
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
