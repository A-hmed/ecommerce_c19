import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/cart/domain/entity/cart.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_cubit.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_state.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/widgets/qty_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cubit = getIt<CartCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  // --- App Bar ---

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: _buildBackButton(context),
      title: _buildAppBarTitle(),
      centerTitle: true,
      actions: _buildAppBarActions(),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.primary),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Cart',
      style: TextStyle(
        color: AppColors.primary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.search, color: AppColors.primary),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.primary),
        onPressed: () {},
      ),
    ];
  }

  // --- Body ---

  Widget _buildBody() {
    return BlocBuilder<CartCubit, CartState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.cartState.isLoading && state.cartState.data == null) {
          return _buildLoadingView();
        }

        if (state.cartState.hasError && state.cartState.data == null) {
          return _buildErrorView(
            state.cartState.errorMessage.isNotEmpty
                ? state.cartState.errorMessage
                : 'Failed to load cart',
          );
        }

        final cart = state.cartState.data;
        if (cart == null || cart.products.isEmpty) {
          return _buildEmptyCartView();
        }

        return _buildCartContentView(cart, state);
      },
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: AppColors.error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _cubit.getCart(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Try Again', style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.remove_shopping_cart_outlined, size: 64, color: AppColors.grey),
          SizedBox(height: 16),
          Text(
            'Your Cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContentView(Cart cart, CartState state) {
    final products = cart.products.values.toList();

    return Column(
      children: [
        Expanded(child: _buildCartItemsList(products, state)),
        _buildBottomBar(cart.totalCartPrice),
      ],
    );
  }

  Widget _buildCartItemsList(List<Product> products, CartState state) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildCartItemCard(products[index], state);
      },
    );
  }

  // --- Cart Item Card ---

  Widget _buildCartItemCard(Product product, CartState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProductImage(product.imageCover),
          const SizedBox(width: 12),
          Expanded(child: _buildProductDetails(product, state)),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.image_not_supported, color: AppColors.grey),
                ),
              )
            : const Center(
                child: Icon(Icons.image_not_supported, color: AppColors.grey),
              ),
      ),
    );
  }

  Widget _buildProductDetails(Product product, CartState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductHeader(product),
        const SizedBox(height: 6),
        _buildProductAttributes(),
        const SizedBox(height: 8),
        _buildPriceAndQuantityRow(product, state),
      ],
    );
  }

  Widget _buildProductHeader(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        _buildDeleteButton(product.id),
      ],
    );
  }

  Widget _buildDeleteButton(String productId) {
    return InkWell(
      onTap: () => _cubit.removeProductFromCart(productId),
      borderRadius: BorderRadius.circular(20),
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          Icons.delete_outline,
          color: AppColors.textDark,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildProductAttributes() {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFC43527),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'Orange | Size: 40',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textDark.withValues(alpha: 0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndQuantityRow(Product product, CartState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'EGP ${product.price}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        _buildItemQuantityControl(product, state),
      ],
    );
  }

  Widget _buildItemQuantityControl(Product product, CartState state) {
    final isLoading = state.cartState.isLoading &&
        state.productIds.contains(product.id);

    return QtyControlWidget(
      qty: product.cartQuantity.toInt(),
      onPlusClick: isLoading
          ? null
          : (_) {
              _cubit.updateProductQty(
                product.id,
                product.cartQuantity.toInt() + 1,
              );
            },
      onMinusClick: isLoading
          ? null
          : (_) {
              if (product.cartQuantity.toInt() > 1) {
                _cubit.updateProductQty(
                  product.id,
                  product.cartQuantity.toInt() - 1,
                );
              } else {
                _cubit.removeProductFromCart(product.id);
              }
            },
    );
  }

  // --- Bottom Bar ---

  Widget _buildBottomBar(num totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildTotalPrice(totalPrice),
            const SizedBox(width: 32),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalPrice(num totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Total price',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textDark.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'EGP $totalPrice',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Check Out',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
