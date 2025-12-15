import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_image_app/screens/shared/presentation/common_cubit/update_value.dart';
import '../bloc/image_bloc.dart';
import '../bloc/image_event.dart';
import '../bloc/image_state.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen>
    with SingleTickerProviderStateMixin {
  final ChangeValue<Color> backgroundColor = ChangeValue(
    const Color(0xFF1E1E1E),
  );
  final ChangeValue<bool> isDarkBackground = ChangeValue(true);
  final ChangeValue<Color?> previousColor = ChangeValue(null);
  final ChangeValue<Color?> targetColor = ChangeValue(null);
  late AnimationController _colorController;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final imageSize = screenWidth * 0.85;

    return BlocBuilder<ChangeValue<Color>, Color>(
      bloc: backgroundColor,
      builder: (context, value) {
        return Scaffold(
          backgroundColor: value,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<ImageBloc, ImageState>(
                  listener: (context, state) {
                    if (state is ImageLoaded) {
                      _extractDominantColor(state.image.url);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: imageSize,
                          height: imageSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _buildImageContent(state),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: state is ImageLoading
                              ? null
                              : () {
                                  context.read<ImageBloc>().add(
                                    FetchRandomImageEvent(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkBackground.state
                                ? Colors.white
                                : const Color(0xFF1E1E1E),
                            foregroundColor: isDarkBackground.state
                                ? const Color(0xFF1E1E1E)
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                          ),
                          child: Text(
                            state is ImageLoading ? 'Loading...' : 'Another',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        AnimatedOpacity(
                          opacity: state is ImageLoading ? 0.5 : 0.7,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            'Tap to discover a new image',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkBackground.state
                                  ? Colors.grey[300]
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageContent(ImageState state) {
    if (state is ImageError) {
      return Container(
        color: const Color(0xFF7F1D1D),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.white70,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load image',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state is ImageLoaded) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: 1,
        child: Image.network(
          state.image.url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: const Color(0xFF2D2D2D),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF7F1D1D),
              child: const Center(
                child: Icon(
                  Icons.broken_image,
                  size: 64,
                  color: Colors.white70,
                ),
              ),
            );
          },
        ),
      );
    }

    return Container(
      color: const Color(0xFF2D2D2D),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Future<void> _extractDominantColor(String url) async {
    try {
      final NetworkImage provider = NetworkImage(url);
      final ImageStream stream = provider.resolve(const ImageConfiguration());

      stream.addListener(
        ImageStreamListener((ImageInfo info, bool _) async {
          final byteData = await info.image.toByteData();
          if (byteData == null) return;

          final pixels = byteData.buffer.asUint8List();
          int r = 0, g = 0, b = 0, count = 0;

          for (int i = 0; i < pixels.length; i += 160) {
            if (i + 2 < pixels.length) {
              r += pixels[i];
              g += pixels[i + 1];
              b += pixels[i + 2];
              count++;
            }
          }

          if (count > 0) {
            r = (r / count).round();
            g = (g / count).round();
            b = (b / count).round();

            final brightness = (r * 299 + g * 587 + b * 114) / 1000;
            final newColor = Color.fromRGBO(r, g, b, 1);
            isDarkBackground.updateValue(brightness < 128);
            previousColor.updateValue(backgroundColor.state);
            targetColor.updateValue(newColor);
            _colorController.reset();
            _colorController.forward();
          }
        }),
      );
    } catch (e) {
      // Fallback
    }
  }

  void initData() {
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _colorController.addListener(() {
      if (previousColor.state != null && targetColor.state != null) {
        backgroundColor.updateValue(
          Color.lerp(
            previousColor.state,
            targetColor.state,
            _colorController.value,
          )!,
        );
      }
    });
    context.read<ImageBloc>().add(FetchRandomImageEvent());
  }
}
