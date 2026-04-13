import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/core/common_widget/app_text_widget.dart';
import 'package:shop_mitra/core/constants/app_colors.dart';

import '../../../domain/entity/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.products});

  final AsyncValue<List<Product>> products;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 12, left: 8, right: 8),
      sliver: products.when(
        loading: () => const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        error: (error, _) => SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(error.toString()),
          ),
        ),
        data: (data) => SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            childAspectRatio: 8 / 9,
            mainAxisSpacing: 8,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = data[index];
            return Container(
              decoration: BoxDecoration(
                color: AppColorConstants.foundationWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 7),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ///  IMAGE SECTION
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: productImage(item.image),
                        ),

                        ///  Wishlist
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// DETAILS SECTION
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Flexible(child: Text(item.productRating.rate.toString())),
                              Flexible(child:  Icon(Icons.star,size: 18,color: item.productRating.rate > 3 ? Colors.green:Colors.red,)),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColorConstants.lightGray,
                                  border: Border(left: BorderSide(width: 1,))
                                ),
                              ),
                              Flexible(child: Text(item.productRating.count.toString())),
                            ],
                          ),
                        ),
                        /// Title
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// Price Row
                        Row(
                          children: [
                            Text(
                              "₹799",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }, childCount: data.length),
        ),
      ),
    );
  }
}

Widget productImage(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: double.infinity,
    height: double.infinity, // ✅ important
    fit: BoxFit.cover,       // ✅ better for product UI

    placeholder: (context, url) => Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    ),

    errorWidget: (context, url, error) => Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.broken_image, size: 40, color: Colors.grey),
          SizedBox(height: 6),
          Text(
            "Image not available",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),

    fadeInDuration: const Duration(milliseconds: 300),
  );
}
