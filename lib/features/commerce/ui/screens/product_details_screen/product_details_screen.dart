import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_cubit.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_state.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/widgets/qty_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _cubit = getIt<CartCubit>();
  int _currentImageIndex = 0;
  int _selectedSize = 40;
  Color _selectedColor = const Color(0xFFC43527);

  final List<Color> _colors = [
    const Color(0xFF2F2929),
    const Color(0xFFC43527),
    const Color(0xFF1F73E8),
    const Color(0xFF1CB93A),
    const Color(0xFFFF6262),
  ];

  final List<int> _sizes = [38, 39, 40, 41, 42];

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
      'Product Details',
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
        onPressed: () {
          Navigator.push(context, AppRouter.cart);
        },
      ),
    ];
  }

  // --- Main Body Structure ---

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(child: _buildScrollableContent()),
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildImageCarousel(),
          const SizedBox(height: 24),
          _buildTitleAndPrice(),
          const SizedBox(height: 16),
          _buildStatsAndQuantity(),
          const SizedBox(height: 24),
          _buildDescription(),
          const SizedBox(height: 24),
          _buildSizesSection(),
          const SizedBox(height: 24),
          _buildColorsSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // --- Image Carousel ---

  Widget _buildImageCarousel() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Stack(
        children: [
          _buildCarouselPageView(),
          _buildFavoriteButton(),
          _buildCarouselIndicators(),
        ],
      ),
    );
  }

  Widget _buildCarouselPageView() {
    final images = widget.product.images.isNotEmpty
        ? widget.product.images
        : [widget.product.imageCover];

    return PageView.builder(
      itemCount: images.length,
      onPageChanged: (index) => setState(() => _currentImageIndex = index),
      itemBuilder: (context, index) => _buildCarouselImageItem(images[index]),
    );
  }

  Widget _buildCarouselImageItem(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.image_not_supported, size: 50, color: AppColors.grey),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: IconButton(
          icon: const Icon(Icons.favorite_border, color: AppColors.primary),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildCarouselIndicators() {
    final totalItems = widget.product.images.isNotEmpty
        ? widget.product.images.length
        : 1;

    return Positioned(
      bottom: 8,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalItems,
          (index) => _buildIndicatorDot(isSelected: _currentImageIndex == index),
        ),
      ),
    );
  }

  Widget _buildIndicatorDot({required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isSelected ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // --- Title & Price ---

  Widget _buildTitleAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductTitle(),
        const SizedBox(width: 8),
        _buildProductPrice(),
      ],
    );
  }

  Widget _buildProductTitle() {
    return Expanded(
      child: Text(
        widget.product.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildProductPrice() {
    return Text(
      'EGP ${widget.product.price}',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  // --- Stats & Cart Quantity ---

  Widget _buildStatsAndQuantity() {
    return Row(
      children: [
        _buildSoldBadge(),
        const SizedBox(width: 12),
        _buildRatingBadge(),
        const Spacer(),
        _buildCartQuantityAction(),
      ],
    );
  }

  Widget _buildSoldBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${widget.product.sold} Sold',
        style: const TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRatingBadge() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          '${widget.product.ratingsAverage} (${widget.product.ratingsQuantity})',
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCartQuantityAction() {
    return BlocBuilder<CartCubit, CartState>(
      bloc: _cubit,
      builder: (context, state) {
        final cartProduct = state.getProductFromCart(widget.product.id);
        final isLoading = state.cartState.isLoading &&
            state.productIds.contains(widget.product.id);

        if (isLoading) {
          return QtyControlWidget(
            qty: cartProduct?.cartQuantity.toInt() ?? 0,
            onPlusClick: null,
            onMinusClick: null,
          );
        }

        if (cartProduct == null) {
          return _buildAddToCartIconButton();
        }

        return _buildActiveQtyControl(cartProduct);
      },
    );
  }

  Widget _buildAddToCartIconButton() {
    return InkWell(
      onTap: () => _cubit.addProductToCart(widget.product.id),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: const [
            Icon(Icons.add_shopping_cart, color: AppColors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Add',
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveQtyControl(Product cartProduct) {
    return QtyControlWidget(
      qty: cartProduct.cartQuantity.toInt(),
      onPlusClick: (_) {
        _cubit.updateProductQty(
          widget.product.id,
          cartProduct.cartQuantity.toInt() + 1,
        );
      },
      onMinusClick: (_) {
        if (cartProduct.cartQuantity.toInt() > 1) {
          _cubit.updateProductQty(
            widget.product.id,
            cartProduct.cartQuantity.toInt() - 1,
          );
        } else {
          _cubit.removeProductFromCart(widget.product.id);
        }
      },
    );
  }

  // --- Description ---

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Description'),
        const SizedBox(height: 8),
        _buildDescriptionText(),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textDark.withValues(alpha: 0.7),
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: widget.product.description.length > 100
                ? '${widget.product.description.substring(0, 100)}...'
                : widget.product.description,
          ),
          if (widget.product.description.length > 100)
            const TextSpan(
              text: ' Read More',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
        ],
      ),
    );
  }

  // --- Sizes Section ---

  Widget _buildSizesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Size'),
        const SizedBox(height: 12),
        _buildSizesList(),
      ],
    );
  }

  Widget _buildSizesList() {
    return Row(
      children: _sizes.map((size) => _buildSizeOption(size)).toList(),
    );
  }

  Widget _buildSizeOption(int size) {
    final isSelected = size == _selectedSize;
    return GestureDetector(
      onTap: () => setState(() => _selectedSize = size),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.primary : AppColors.transparent,
        ),
        child: Text(
          '$size',
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? AppColors.white : AppColors.textDark,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // --- Colors Section ---

  Widget _buildColorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Color'),
        const SizedBox(height: 12),
        _buildColorsList(),
      ],
    );
  }

  Widget _buildColorsList() {
    return Row(
      children: _colors.map((color) => _buildColorOption(color)).toList(),
    );
  }

  Widget _buildColorOption(Color color) {
    final isSelected = color == _selectedColor;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: AppColors.white, size: 24)
            : null,
      ),
    );
  }

  // --- Common Section Header ---

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  // --- Bottom Bar ---

  Widget _buildBottomBar() {
    return BlocBuilder<CartCubit, CartState>(
      bloc: _cubit,
      builder: (context, state) {
        final cartProduct = state.getProductFromCart(widget.product.id);
        final qty = cartProduct?.cartQuantity.toInt() ?? 1;

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
                _buildTotalPrice(qty),
                const SizedBox(width: 32),
                _buildAddToCartButton(cartProduct),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalPrice(int qty) {
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
          'EGP ${widget.product.price * qty}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(Product? cartProduct) {
    final isInCart = cartProduct != null;
    if (isInCart) {
      return Expanded(child: _buildCartQuantityAction());
    }
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (!isInCart) {
            _cubit.addProductToCart(widget.product.id);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isInCart ? AppColors.grey : AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, color: AppColors.white),
            const SizedBox(width: 8),
            Text(
              isInCart ? 'Item in Cart' : 'Add to cart',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
