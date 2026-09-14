import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/ad_card.dart';
import 'package:flutter/material.dart';

class AdsSection extends StatefulWidget {
  final List<Map<String, dynamic>> ads;

  const AdsSection({super.key, required this.ads});

  @override
  State<AdsSection> createState() => _AdsSectionState();
}

class _AdsSectionState extends State<AdsSection> {
  int _currentAdIndex = 0;
  final PageController _adPageController = PageController();

  @override
  void dispose() {
    _adPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _adPageController,
            itemCount: widget.ads.length,
            onPageChanged: (index) {
              setState(() {
                _currentAdIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return AdCard(ad: widget.ads[index]);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.ads.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentAdIndex == index ? 10 : 8,
              height: _currentAdIndex == index ? 10 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentAdIndex == index
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
