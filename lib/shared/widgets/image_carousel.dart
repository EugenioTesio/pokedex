import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    required this.imageUrls,
    super.key,
  });

  final List<String> imageUrls;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: imageUrls
          .map(
            (item) => Center(
              child: Image.network(
                item,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
