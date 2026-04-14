import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../notifier/dashboard_controller.dart';

class AdsCarousel extends ConsumerWidget {
  const AdsCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ads = ref.watch(adsProvider);

    if (ads.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: CarouselSlider.builder(
        itemCount: ads.length,
        itemBuilder: (context, index, realIndex) {
          final imageUrl = ads[index];

          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,

              // Loader while image loads
              progressIndicatorBuilder:
                  (context, url, downloadProgress) => Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * (9 / 20),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.grey,width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 🔹 Error fallback
              errorWidget: (context, url, error) => Image.asset(
                "assets/image/photo-1483985988355-763728e1935b.jpg",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          aspectRatio: 20 / 9,
          viewportFraction: 0.85,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration:
          const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

