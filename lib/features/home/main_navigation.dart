import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({super.key});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _glowController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    debugPrint('=== MAIN NAV: async init start ===');
    
    // Initialize animation controller
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    // Wait a frame before starting animations
    await Future.delayed(Duration.zero);
    
    if (mounted) {
      _glowController.repeat(reverse: true);
      setState(() {
        _isInitialized = true;
      });
      debugPrint('=== MAIN NAV: async init complete ===');
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('=== MAIN NAV: build, initialized=$_isInitialized ===');
    
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: Color(0xFF030712),
        body: Center(
          child: CircularProgressIndicator(color: Colors.pink),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.gray950,
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

          // Current page
          _buildCurrentPage(),

          // Settings button
          SafeArea(
            child: Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  // Settings navigation would go here
                },
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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
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

  Widget _buildBottomNavBar() {
    final tabs = [
      _TabData(Icons.bolt, 'Spark', AppColors.sparkGradient),
      _TabData(Icons.favorite, 'Play', AppColors.playGradient),
      _TabData(Icons.trending_up, 'Patterns', AppColors.patternsGradient),
      _TabData(Icons.auto_awesome, 'Future', AppColors.futureGradient),
      _TabData(Icons.shield, 'Mediator', AppColors.mediatorGradient),
      _TabData(Icons.archive, 'Vault', AppColors.vaultGradient),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (index) {
              final tab = tabs[index];
              final isActive = _currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    debugPrint('=== TAB CHANGED to $index ===');
                    setState(() => _currentIndex = index);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: tab.gradient.first.withOpacity(0.3),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  tab.icon,
                                  color: isActive
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  size: 24,
                                ),
                              ),
                              if (isActive)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: AnimatedBuilder(
                                    animation: _glowController,
                                    builder: (context, child) {
                                      return Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                _glowController.value * 0.6,
                                              ),
                                              blurRadius: 4,
                                              spreadRadius: 1,
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
                        Text(
                          tab.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                            color: isActive
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabData {
  final IconData icon;
  final String label;
  final List<Color> gradient;

  _TabData(this.icon, this.label, this.gradient);
}

// ============================================
// SIMPLIFIED TABS - NO COMPLEX ANIMATIONS
// ============================================

class SparkTab extends StatelessWidget {
  const SparkTab({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('=== SPARK TAB: build ===');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: AppColors.sparkGradient,
              ),
            ),
            child: const Center(
              child: Text(
                '78',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Spark Tab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayTab extends StatelessWidget {
  const PlayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: AppColors.playGradient,
              ),
            ),
            child: const Icon(
              Icons.favorite,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Play Tab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class PatternsTab extends StatelessWidget {
  const PatternsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: AppColors.patternsGradient,
              ),
            ),
            child: const Icon(
              Icons.trending_up,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Patterns Tab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class FutureTab extends StatelessWidget {
  const FutureTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: AppColors.futureGradient,
              ),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Future Tab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class MediatorTab extends StatelessWidget {
  const MediatorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: AppColors.mediatorGradient,
              ),
            ),
            child: const Icon(
              Icons.shield,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Mediator Tab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class VaultTab extends StatelessWidget {
  const VaultTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: AppColors.vaultGradient,
              ),
            ),
            child: const Icon(
              Icons.archive,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Vault Tab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
