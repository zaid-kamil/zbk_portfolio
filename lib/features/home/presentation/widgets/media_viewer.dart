import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/iframe_view.dart';

enum MediaType { image, video }

class MediaItem {
  final MediaType type;
  final String url;
  final String thumbnailUrl;

  MediaItem({
    required this.type,
    required this.url,
    required this.thumbnailUrl,
  });
}

class MediaViewer extends StatefulWidget {
  final List<MediaItem> items;
  final int initialIndex;

  const MediaViewer({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  @override
  State<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return item.type == MediaType.video
                  ? _buildVideo(item.url)
                  : _buildImage(item.url);
            },
          ),
          _buildNavigationArrows(),
          _buildCloseButton(),
        ],
      ),
    );
  }

  Widget _buildVideo(String url) {
    final videoId = _extractYouTubeId(url);
    if (videoId == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48.0,
        vertical: 80.0,
      ),
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: IframeView(
            src: 'https://www.youtube.com/embed/$videoId?rel=0&showinfo=0',
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 3.0,
      child: Center(
        child: Image.network(
          url,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildNavigationArrows() {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _currentIndex > 0
                  ? IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    )
                  : const SizedBox(width: 48),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _currentIndex < widget.items.length - 1
                  ? IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                      onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    )
                  : const SizedBox(width: 48),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white, size: 32),
        onPressed: () => Navigator.of(context).pop(),
        padding: const EdgeInsets.all(24),
      ),
    );
  }

  String? _extractYouTubeId(String url) {
    final regex = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/|watch\?v=))([^#\&\?]*).*',
    );
    final match = regex.firstMatch(url);
    return match?.group(1);
  }
}
