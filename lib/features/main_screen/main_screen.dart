import 'package:flutter/material.dart';
import 'package:responsible_unicorn/constants/app_color.dart';
import 'package:responsible_unicorn/features/calculation_screen/presentation/calculation_screen.dart';
import 'package:responsible_unicorn/features/main_screen/info_screen/info_screen.dart';

class ResponsibleUnicorn extends StatefulWidget {
  const ResponsibleUnicorn({super.key});

  @override
  State<ResponsibleUnicorn> createState() => _ResponsibleUnicornState();
}

class _ResponsibleUnicornState extends State<ResponsibleUnicorn> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ResponsiveTabsPage(),
    TabsPage(),
    Center(child: Text('Отчет', style: TextStyle(fontSize: 24))),
  ];

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth >= 800;

        return Scaffold(
          // ❌ Remove default AppBar on desktop
          appBar:
              isDesktop
                  ? null
                  : AppBar(
                    title: Text(
                      'Обзор',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

          // ✅ Keep drawer only for mobile
          drawer:
              isDesktop
                  ? null
                  : CustomDrawer(
                    selectedIndex: _selectedIndex,
                    onSelect: (index) {
                      _onSelect(index);
                      Navigator.pop(context); // Close drawer on mobile
                    },
                  ),

          // ✅ Custom layout for desktop
          body: Row(
            children: [
              if (isDesktop)
                Expanded(
                  flex: 1, // drawer takes 1 part (can be adjusted)
                  child: CustomDrawer(
                    selectedIndex: _selectedIndex,
                    onSelect: _onSelect,
                  ),
                ),
              Expanded(
                flex: 4, // main content takes 4 parts (can be adjusted)
                child: Column(
                  children: [
                    // ✅ This is the AppBar shifted to the right
                    isDesktop
                        ? Container(
                          height: kToolbarHeight,
                          width: double.infinity,
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Обзор',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        )
                        : Container(),
                    // ✅ Your actual page content
                    Expanded(child: _pages[_selectedIndex]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: AppColors.white,
      child: Container(
        padding: EdgeInsets.only(top: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  "DataTable",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildTile(
              icon: Icons.home,
              title: "Информация",
              index: 0,
              isSelected: selectedIndex == 0,
              onTap: () => onSelect(0),
            ),
            _buildTile(
              icon: Icons.person_2_rounded,
              title: "Расчеты",
              index: 1,
              isSelected: selectedIndex == 1,
              onTap: () => onSelect(1),
            ),
            _buildTile(
              icon: Icons.attach_money,
              title: "Отчет",
              index: 2,
              isSelected: selectedIndex == 2,
              onTap: () => onSelect(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 5,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.blue : AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.blue : AppColors.grey,
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.blue : AppColors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
