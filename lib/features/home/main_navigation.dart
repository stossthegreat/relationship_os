import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../spark/spark_tab.dart';
import '../play/play_tab.dart';
import '../patterns/patterns_tab.dart';
import '../future/future_tab.dart';
import '../mediator/mediator_tab.dart';
import '../vault/vault_tab.dart';
import '../settings/settings_page.dart';

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({super.key});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _glowController;

  final List<_TabConfig> _tabs = [
    _TabConfig(
      icon: Icons.bolt,
      label: 'Spark',
      gradient: AppColors.sparkGradient,
    ),
    _TabConfig(
      icon: Icons.favorite,
      label: 'Play',
      gradient: AppColors.playGradient,
    ),
    _TabConfig(
      icon: Icons.trending_up,
      label: 'Patterns',
      gradient: AppColors.patternsGradient,
    ),
    _TabConfig(
      icon: Icons.auto_awesome,
      label: 'Future',
      gradient: AppColors.futureGradient,
    ),
    _TabConfig(
      icon: Icons.shield,
      label: 'Mediator',
      gradient: AppColors.mediatorGradient,
    ),
    _TabConfig(
      icon: Icons.archive,
      label: 'Vault',
      gradient: AppColors.vaultGradient,
    ),
  ];

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const SparkTab();
      case 1:
        return const PlayTab();
      case 2:
        return const PatternsTab();
      case 3:
        return const FutureTab();
      case 4:
        return const MediatorTab();
      case 5:
        return const VaultTab();
      default:
        return const SparkTab();
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('=== MAIN NAV: initState start ===');
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      value: 0.5, // Static value, no animation
    );
    // DO NOT call repeat() - causes Android crash in release mode
    debugPrint('=== MAIN NAV: initState complete ===');
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('=== MAIN NAV: build start, index=$_currentIndex ===');
    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Dark background
      body: SafeArea(
        child: Column(
          children: [
            // Simple header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _tabs[_currentIndex].label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: _openSettings,
                  ),
                ],
              ),
            ),
            // Current page
            Expanded(
              child: _getPage(_currentIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isActive = _currentIndex == index;
              
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      color: isActive ? tab.gradient.first : Colors.grey,
                      size: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab.label,
                      style: TextStyle(
                        color: isActive ? tab.gradient.first : Colors.grey,
                        fontSize: 12,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabConfig {
  final IconData icon;
  final String label;
  final List<Color> gradient;

  _TabConfig({
    required this.icon,
    required this.label,
    required this.gradient,
  });
}
