import 'package:flutter/material.dart';

class SectionScaffold extends StatelessWidget {
  const SectionScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.footer,
  });
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? footer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...children.map(
                    (w) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: w,
                    ),
                  ),
                  if (footer != null) footer!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
