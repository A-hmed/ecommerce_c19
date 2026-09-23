import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:flutter/material.dart';

class QtyControlWidget extends StatelessWidget {
  final int qty;
  final ValueChanged<int>? onPlusClick;
  final ValueChanged<int>? onMinusClick;

  const QtyControlWidget({
    super.key,
    required this.qty,
    required this.onPlusClick,
    required this.onMinusClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: onMinusClick == null? AppColors.grey: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(icon: Icons.remove, onTap: () => onMinusClick?.call(qty)),
          const SizedBox(width: 16),
          Text(
            qty.toString(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          _buildIconButton(icon: Icons.add, onTap: () => onPlusClick?.call(qty)),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
        ),
        child: Center(child: Icon(icon, color: AppColors.white, size: 14)),
      ),
    );
  }
}
