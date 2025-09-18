import 'package:flutter/material.dart';
import 'form_section.dart';
import '../../widgets/atoms.dart';

class HighlightVideosSection extends StatelessWidget {
  const HighlightVideosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Highlight Videos',
      fields: const [
        AppTextField(label: 'Video Title', hint: 'Enter video title'),
        AppTextField(label: 'Upload Video', hint: 'Select document / MP4, MOV'),
        AppTextField(label: 'Or YouTube/Vimeo link', hint: 'https://www.youtube.com/watch?v='),
      ],
    );
  }
}
