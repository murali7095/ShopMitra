import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mitra/feature/dashboard/data/model/product.dart';

import '../notifier/products_notifier.dart';


class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsNotifierProvider);

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
    );
  }
}
