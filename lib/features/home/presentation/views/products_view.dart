import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/core/constants/app_strings.dart';
import 'package:stor_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:stor_app/features/home/presentation/view_model/home_state.dart';
import 'package:stor_app/features/home/presentation/views/widgets/error_view.dart';
import 'package:stor_app/features/home/presentation/views/widgets/product_card.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.products),
        actions: [
          IconButton(
            onPressed: () => context.read<HomeCubit>().getProducts(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeFailure) {
            return ErrorView(
              message: state.errorMessage,
              onRetry: context.read<HomeCubit>().getProducts,
            );
          }
          final products = (state as HomeSuccess).products;
          return RefreshIndicator(
            onRefresh: context.read<HomeCubit>().getProducts,
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: .68,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            ),
          );
        },
      ),
    );
  }
}
