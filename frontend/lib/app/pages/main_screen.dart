import 'package:flutter/material.dart';
import 'package:cosmetics_store/features/cart/presentation/pages/cart_screen.dart';
import 'package:cosmetics_store/features/catalog/presentation/pages/catalog_screen.dart';
import 'package:cosmetics_store/features/home/presentation/pages/home_screen.dart';
import 'package:cosmetics_store/features/profile/presentation/pages/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(top: BorderSide(color: Color(0xFF70757F))),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xffFFFFFF),
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0xFF70757F),
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/icons/House.png')),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/icons/MagnifyingGlass.png'),
              ),
              label: 'Каталог',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/icons/ShoppingCartSimple.png'),
              ),
              label: 'Корзина',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/icons/User.png')),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
