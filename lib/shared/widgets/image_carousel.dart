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
            (item) => Card(
              child: Center(
                child: Image.network(
                  item,
                  fit: BoxFit.fill,
                  scale: 0.1,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
