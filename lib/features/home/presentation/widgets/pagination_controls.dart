import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.pageCount,
    this.onPreviousPage,
    this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onPreviousPage,
        ),
        Text('${currentPage + 1} / $pageCount'),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: onNextPage,
        ),
      ],
    );
  }
}