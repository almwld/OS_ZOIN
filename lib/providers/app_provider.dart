import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _currentCategory = 'ATTACK';
  
  String get currentCategory => _currentCategory;
  
  void setCategory(String category) {
    _currentCategory = category;
    notifyListeners();
  }

  List<Map<String, dynamic>> getCurrentCategoryApps() {
    final allApps = {
      'ATTACK': [
        {'name': 'WIFI', 'icon': Icons.wifi, 'color': '#FBBF24'},
        {'name': 'EXPLOIT', 'icon': Icons.security, 'color': '#FF6B6B'},
        {'name': 'CRACKER', 'icon': Icons.lock_open, 'color': '#FF4444'},
        {'name': 'DDoS', 'icon': Icons.flash_on, 'color': '#FF9800'},
        {'name': 'DATABASE', 'icon': Icons.storage, 'color': '#38BDF8'},
        {'name': 'CLOUD', 'icon': Icons.cloud, 'color': '#5EEAD4'},
      ],
      'DEFENSE': [
        {'name': 'STEALTH', 'icon': Icons.visibility_off, 'color': '#34D399'},
        {'name': 'CRYPTO', 'icon': Icons.lock, 'color': '#C084FC'},
        {'name': 'BATTERY', 'icon': Icons.battery_charging_full, 'color': '#4CAF50'},
      ],
      'ANALYSIS': [
        {'name': 'NETWORK', 'icon': Icons.network_check, 'color': '#2DD4BF'},
        {'name': 'FORENSICS', 'icon': Icons.analytics, 'color': '#F472B6'},
        {'name': 'TEXT', 'icon': Icons.text_fields, 'color': '#A3E635'},
        {'name': 'TOOLS', 'icon': Icons.build, 'color': '#818CF8'},
      ],
      'TOOLS': [
        {'name': 'CALC', 'icon': Icons.calculate, 'color': '#A78BFA'},
        {'name': 'NOTES', 'icon': Icons.note, 'color': '#EAB308'},
        {'name': 'WEATHER', 'icon': Icons.wb_sunny, 'color': '#FBBF24'},
        {'name': 'MAPS', 'icon': Icons.map, 'color': '#84CC16'},
        {'name': 'RADIO', 'icon': Icons.radio, 'color': '#FB7185'},
        {'name': 'SHARE', 'icon': Icons.share, 'color': '#06B6D4'},
      ],
    };
    
    return allApps[_currentCategory] ?? [];
  }
}
