import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/core/constants/app_colors.dart';
import 'package:shop_mitra/feature/dashboard/presentation/notifier/dashboard_controller.dart';
import 'package:shop_mitra/feature/dashboard/presentation/screens/widgets/ads_carousel_widget.dart';
import 'package:shop_mitra/feature/dashboard/presentation/screens/widgets/app_header.dart';
import 'package:shop_mitra/feature/dashboard/presentation/screens/widgets/category_widget.dart';
import 'package:shop_mitra/feature/dashboard/presentation/screens/widgets/search_widget.dart';

import '../../domain/entity/product.dart';
import 'widgets/product_item_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsNotifierProvider);

    final List<Widget> _pages = [
      _homePage(products),
      const Center(child: Text("Search")),
      const Center(child: Text("Cart")),
      const Center(child: Text("Profile")),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColorConstants.foundationWhite,

      body: _pages[_currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColorConstants.foundationWhite.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home, "Home", 0),
              _navItem(Icons.search, "Search", 1),
              _navItem(Icons.shopping_bag, "Cart", 2),
              _navItem(Icons.person, "Account", 3),
            ],
          ),
        ),
      ),
    );
  }
  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColorConstants.mainColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColorConstants.mainColor
                  : Colors.grey,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: AppColorConstants.mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  ///
  Widget _homePage(AsyncValue<List<Product>> products) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScrollView(
        slivers: [
          AppHeader(),
          SearchWidget(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            sliver: AdsCarousel(),
          ),
          CategoryWidget(),
          ProductItem(products: products),
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
