import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/features/home/presentation/view_model/auth_cubit.dart';
import 'package:stor_app/features/home/presentation/view_model/auth_state.dart';
import 'package:stor_app/features/home/presentation/views/widgets/error_view.dart';
import 'package:stor_app/features/home/presentation/views/widgets/product_card.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(Dio())..getProducts(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المنتجات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => context.read<ProductsCubit>().getProducts(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading || state is ProductsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductsFailure) {
            return ErrorView(
              message: state.errorMessage,
              onRetry: context.read<ProductsCubit>().getProducts,
            );
          }
          final products = (state as ProductsSuccess).products;
          return RefreshIndicator(
            onRefresh: context.read<ProductsCubit>().getProducts,
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
