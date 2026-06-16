import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/app_provider.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.forward();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final primaryColor = themeProvider.primaryColor;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    Color(0xFF0A2E38),
                    Color(0xFF031217),
                    Color(0xFF000000),
                  ],
                )
              : const RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    Color(0xFFE0F7FA),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ✅ شريط الحالة مع الوقت
              _buildStatusBar(context, primaryColor, textColor),
              
              // ✅ العنوان الرئيسي ZION OS
              _buildHeader(context, primaryColor, textColor),
              
              // ✅ أزرار الفئات (ATTACK, DEFENSE, ANALYSIS, TOOLS)
              _buildCategoryTabs(context, primaryColor, textColor),
              
              const SizedBox(height: 12),
              
              // ✅ شبكة التطبيقات
              Expanded(
                child: _buildAppGrid(context, primaryColor, textColor),
              ),
              
              // ✅ شريط الأدوات السفلي (TERM, FILES, WEB, HUB, SET)
              _buildBottomBar(context, primaryColor, textColor),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ شريط الحالة مع الوقت
  Widget _buildStatusBar(BuildContext context, Color primaryColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.wifi, color: textColor.withOpacity(0.5), size: 16),
              const SizedBox(width: 8),
              Icon(Icons.signal_cellular_alt, color: textColor.withOpacity(0.5), size: 16),
              const SizedBox(width: 8),
              Icon(Icons.battery_full, color: textColor.withOpacity(0.5), size: 16),
            ],
          ),
          Text(
            _currentTime,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ العنوان الرئيسي مع تأثير زجاجي
  Widget _buildHeader(BuildContext context, Color primaryColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.15),
            primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Z',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'ZION OS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ أزرار الفئات (مع تأثيرات متوهجة)
  Widget _buildCategoryTabs(BuildContext context, Color primaryColor, Color textColor) {
    final categories = [
      {'name': 'ATTACK', 'color': const Color(0xFFFF5722), 'icon': Icons.flash_on},
      {'name': 'DEFENSE', 'color': const Color(0xFF4CAF50), 'icon': Icons.shield},
      {'name': 'ANALYSIS', 'color': const Color(0xFF2196F3), 'icon': Icons.analytics},
      {'name': 'TOOLS', 'color': const Color(0xFF9C27B0), 'icon': Icons.build},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: (Colors.white).withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: categories.map((category) {
          return Expanded(
            child: _buildCategoryButton(
              context,
              category['name'] as String,
              category['color'] as Color,
              category['icon'] as IconData,
              primaryColor,
              textColor,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String name,
    Color color,
    IconData icon,
    Color primaryColor,
    Color textColor,
  ) {
    final isSelected = Provider.of<AppProvider>(context).currentCategory == name;
    
    return GestureDetector(
      onTap: () {
        Provider.of<AppProvider>(context, listen: false).setCategory(name);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ] : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? color : color.withOpacity(0.5), size: 16),
            const SizedBox(width: 6),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? color : textColor.withOpacity(0.6),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ شبكة التطبيقات (مع تأثيرات Glassmorphism)
  Widget _buildAppGrid(BuildContext context, Color primaryColor, Color textColor) {
    final appProvider = Provider.of<AppProvider>(context);
    final apps = appProvider.getCurrentCategoryApps();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        final color = Color(int.parse(app['color'].toString().replaceFirst('#', '0xFF')));
        
        return _buildAppItem(
          context,
          app['name'] as String,
          app['icon'] as IconData? ?? Icons.apps,
          color,
          primaryColor,
          textColor,
        );
      },
    );
  }

  Widget _buildAppItem(
    BuildContext context,
    String name,
    IconData icon,
    Color color,
    Color primaryColor,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🔄 فتح $name...'),
            backgroundColor: color,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ شريط الأدوات السفلي (بأسلوب iOS/Android)
  Widget _buildBottomBar(BuildContext context, Color primaryColor, Color textColor) {
    final tools = [
      {'name': 'TERM', 'icon': Icons.terminal, 'color': const Color(0xFF00D4FF)},
      {'name': 'FILES', 'icon': Icons.folder, 'color': const Color(0xFF10B981)},
      {'name': 'WEB', 'icon': Icons.public, 'color': const Color(0xFF3B82F6)},
      {'name': 'HUB', 'icon': Icons.dashboard, 'color': const Color(0xFF8B5CF6)},
      {'name': 'SET', 'icon': Icons.settings, 'color': const Color(0xFFF59E0B)},
    ];

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tools.map((tool) {
          final color = tool['color'] as Color;
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('🔄 فتح ${tool['name']}...'),
                  backgroundColor: color,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tool['icon'] as IconData,
                    color: color,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    tool['name'] as String,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
