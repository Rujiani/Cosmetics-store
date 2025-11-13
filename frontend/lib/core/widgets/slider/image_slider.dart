// lib/features/home/presentation/widgets/image_slider.dart
import 'package:cosmetics_store/core/widgets/slider/promotion_entity.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<Promotion> promotions;

  const ImageSlider({super.key, required this.promotions});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 359,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.promotions.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.promotions[index].image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.photo,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                height: 166,
                top: 193,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Color(0xFF2C2C2C), Colors.transparent],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 245,
                left: 24,
                child: Text(
                  widget.promotions[index].mainText,
                  style: TextStyle(
                    fontFamily: 'VelaSans',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 35.05,
                  ),
                ),
              ),

              Positioned(
                top: 290,
                left: 24,
                child: Text(
                  widget.promotions[index].promotionText,
                  style: TextStyle(
                    fontFamily: 'VelaSans',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),

              Positioned(
                top: 50,
                left: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.promotions.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i
                ? Color(0xFFD9D9D9)
                : Color.fromARGB(Color.getAlphaFromOpacity(0.5), 217, 217, 217),
          ),
        ),
      );
    }
    return indicators;
  }
}
