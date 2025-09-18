import 'package:flutter/material.dart';

class VideosStep extends StatefulWidget {
  const VideosStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<VideosStep> createState() => _VideosStepState();
}

class _VideosStepState extends State<VideosStep> {
  final _titleCtrl = TextEditingController();
  final _linkCtrl = TextEditingController();

  bool get _complete =>
      _titleCtrl.text.trim().isNotEmpty || _linkCtrl.text.trim().isNotEmpty;
  void _notify() => widget.onCompleteChanged(_complete);

  @override
  void initState() {
    super.initState();
    _titleCtrl.addListener(_notify);
    _linkCtrl.addListener(_notify);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _linkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notify());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Highlight Videos',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Video Title',
                hintText: 'Enter video title',
              ),
            ),
            const SizedBox(height: 12),

            // Placeholder upload + link (hook into your picker later)
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file_rounded),
              label: const Text('Upload Video (MP4/MOV)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _linkCtrl,
              decoration: const InputDecoration(
                labelText: 'Or Link',
                hintText: 'https://youtu.be/...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
