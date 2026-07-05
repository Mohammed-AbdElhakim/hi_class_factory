import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final bool isFullScreen;

  const LoadingWidget({
    super.key,
    this.message,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final spinner = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );

    if (isFullScreen) {
      return Scaffold(
        body: Center(child: spinner),
      );
    }

    return Center(child: spinner);
  }
}
