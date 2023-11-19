import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({
    this.onChanged,
    required this.selectedBottomBarItem,
  });

  final Function(BottomBarEnum)? onChanged;
  final BottomBarEnum selectedBottomBarItem;

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: Icons.home,
      type: BottomBarEnum.Main,
    ),
    BottomMenuModel(
      icon: Icons.search,
      type: BottomBarEnum.Search,
    ),
    BottomMenuModel(
      icon: Icons.favorite,
      type: BottomBarEnum.Favorite,
    ),
    BottomMenuModel(
      icon: Icons.shopping_cart,
      type: BottomBarEnum.Cart,
    ),
    BottomMenuModel(
      icon: Icons.person,
      type: BottomBarEnum.Profile,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = bottomMenuList
        .indexWhere((item) => item.type == widget.selectedBottomBarItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[400],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onChanged?.call(bottomMenuList[index].type);
        },
        items: List.generate(
          bottomMenuList.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(bottomMenuList[index].icon),
            label: '',
          ),
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Main,
  Search,
  Favorite,
  Cart,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({required this.icon, required this.type});

  final IconData icon;
  final BottomBarEnum type;
}



void navigateToPage(BuildContext context, BottomBarEnum item) {
  switch (item) {
    case BottomBarEnum.Main:
      Navigator.of(context).pushReplacementNamed('/main_page');
      break;
    case BottomBarEnum.Search:
      Navigator.of(context).pushReplacementNamed('/search');
      break;
    case BottomBarEnum.Favorite:
      Navigator.of(context).pushReplacementNamed('/favorites_page');
      break;
    case BottomBarEnum.Cart:
      Navigator.of(context).pushReplacementNamed('/my_cart_screen');
      break;
    case BottomBarEnum.Profile:
      Navigator.of(context).pushReplacementNamed('/my_profile_screen');
      break;
  }
}









  