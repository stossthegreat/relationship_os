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

  final List<Widget> _pages = const [
    SparkTab(),
    PlayTab(),
    PatternsTab(),
    FutureTab(),
    MediatorTab(),
    VaultTab(),
  ];

  @override
  void initState() {
    super.initState();
    debugPrint('=== MAIN NAV: initState start ===');
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [
                  AppColors.purple500.withOpacity(0.1),
                  AppColors.gray950,
                ],
              ),
            ),
          ),

          // Bottom radial gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 1.0,
                  colors: [
                    AppColors.blue500.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Current page with settings button overlay
          Stack(
            children: [
              _pages[_currentIndex],
              
              // Settings button
              SafeArea(
                child: Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: _openSettings,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white.withOpacity(0.9),
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Active indicator line
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 3,
                width: MediaQuery.of(context).size.width / _tabs.length,
                margin: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width / _tabs.length) *
                      _currentIndex,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _tabs[_currentIndex].gradient,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: _tabs[_currentIndex].gradient.first.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              
              // Navigation items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_tabs.length, (index) {
                    final tab = _tabs[index];
                    final isActive = _currentIndex == index;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _currentIndex = index),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: isActive
                                    ? LinearGradient(
                                        colors: tab.gradient,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                color: isActive
                                    ? null
                                    : Colors.white.withOpacity(0.05),
                                border: Border.all(
                                  color: isActive
                                      ? Colors.transparent
                                      : Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                                boxShadow: isActive
                                    ? [
                                        BoxShadow(
                                          color: tab.gradient.first.withOpacity(0.5),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Stack(
                                children: [
                                  // Icon
                                  Center(
                                    child: Icon(
                                      tab.icon,
                                      color: isActive
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                      size: 24,
                                    ),
                                  ),
                                  
                                  // Pulse dot
                                  if (isActive)
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: AnimatedBuilder(
                                        animation: _glowController,
                                        builder: (context, child) {
                                          return Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white.withOpacity(
                                                    _glowController.value * 0.8,
                                                  ),
                                                  blurRadius: 8,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            
                            // Label
                            ShaderMask(
                              shaderCallback: (bounds) => isActive
                                  ? LinearGradient(
                                      colors: tab.gradient,
                                    ).createShader(bounds)
                                  : const LinearGradient(
                                      colors: [Colors.white, Colors.white],
                                    ).createShader(bounds),
                              child: Text(
                                tab.label,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isActive
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: isActive
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
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

