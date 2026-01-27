import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shop_mitra/core/common_widget/app_text_widget.dart';
import 'package:shop_mitra/core/constants/app_colors.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';
import 'package:shop_mitra/feature/dashboard/presentation/notifier/dashboard_controller.dart';

import '../notifier/products_notifier.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsNotifierProvider);
    return Scaffold(
      backgroundColor: AppColorConstants.foundationWhite,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          slivers: [
            AppHeader(),
            SearchWidget(),
            SliverPadding(
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
                data: (data) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(item.title),
                      );
                    },
                    childCount: data.length,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 12, left: 8, right: 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColorConstants.foundationWhite,
                  border: Border.all(
                    color: AppColorConstants.brown_medium,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      Icons.search_rounded,
                      color: AppColorConstants.brown_medium,
                      size: 35,
                      fontWeight: FontWeight.w500,
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hint: AppTextWidget(
                            fontSize: 20,
                            text: "Search",
                            fontWeight: FontWeight.w400,
                            color: AppColorConstants.brown_dark,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(7.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColorConstants.brown_medium,
              ),
              child: Icon(
                Icons.filter_list_outlined,
                color: AppColorConstants.foundationWhite,
                size: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColorConstants.foundationWhite,
      pinned: true,
      // expandedHeight: 200,
      floating: false,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorConstants.bg_cream,
          ),
          child: Icon(
            Icons.notification_add_sharp,
            color: AppColorConstants.black121212,
          ),
        ),
      ],
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            text: "Location",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColorConstants.black000000,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_rounded,
                color: AppColorConstants.brown_dark,
                size: 30,
              ),
              SizedBox(width: 4),
              AppTextWidget(
                text: "HYDERABAD, INDIA",
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColorConstants.black000000,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColorConstants.black000000,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/* SliverPadding(
              padding: EdgeInsets.only(top: 12, left: 8, right: 8),
              sliver: SliverToBoxAdapter(
                child: AppTextWidget(
                  text: "Category",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 12)),
            SliverPadding(
              padding:  EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                 //   margin: EdgeInsets,
                   // padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColorConstants.brown_soft,
                      shape: BoxShape.circle,
                    ),

                    child: Icon(Icons.man_3_outlined),
                  );
                },
                  childCount:4,

                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                 // mainAxisExtent: 10,
                    mainAxisSpacing: 10,
                  crossAxisSpacing: 10
                ),
              ),
            ),*/

/*final state = ref.watch(productsNotifierProvider);

    // Convert AsyncValue → Either for UI fold
    final eitherState = state.when<Either<String, List<Product>>>(
      data: (u) => Right(u),
      loading: () => const Right([]), // treat loading as empty right
      error: (e, _) => Left(e.toString()),
    );

    return eitherState.fold(
          (error) => Scaffold(
        appBar: AppBar(title: const Text('Users')),
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
          (users) => Scaffold(
        appBar: AppBar(title: const Text('Users')),
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, i) {
            final u = users[i];
            return ListTile(
              title: Text(u.title),
              subtitle: Text(u.description),
            );
          },
        ),
      ),
    );*/
