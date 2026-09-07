import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AdsCarouselWidget extends StatefulWidget {
  const AdsCarouselWidget({super.key});

  @override
  State<AdsCarouselWidget> createState() => _AdsCarouselWidgetState();
}

class _AdsCarouselWidgetState extends State<AdsCarouselWidget> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> _ads = const [
    {
      'title': 'UP TO 25% OFF',
      'subtitle': 'For all Headphones & AirPods',
      'buttonText': 'Shop Now',
    },
    {
      'title': 'UP TO 30% OFF',
      'subtitle': 'For all Electronics & Laptops',
      'buttonText': 'Explore',
    },
    {
      'title': 'SPECIAL OFFER',
      'subtitle': 'Get 15% cashback on beauty items',
      'buttonText': 'Claim Now',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _ads.length,
            itemBuilder: (context, index) {
              final ad = _ads[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ad['title']!,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ad['subtitle']!,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                ad['buttonText']!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.headphones,
                        size: 90,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _ads.length,
                (index) => Container(
                  width: _currentIndex == index ? 10 : 8,
                  height: _currentIndex == index ? 10 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
