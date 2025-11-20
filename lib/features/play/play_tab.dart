import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class PlayTab extends StatelessWidget {
  const PlayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          // Background orbs
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -60,
                right: -40,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.rose500.withOpacity(0.1),
                        AppColors.rose500.withOpacity(0.0),
                      ],
                    ),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 2.seconds)
                    .then()
                    .fadeOut(duration: 2.seconds),
              ),

              Positioned(
                top: 160,
                left: -80,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.pink500.withOpacity(0.1),
                        AppColors.pink500.withOpacity(0.0),
                      ],
                    ),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 2.seconds, delay: 1.5.seconds)
                    .then()
                    .fadeOut(duration: 2.seconds),
              ),

              Column(
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildTitle(),
                ],
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Quest cards
          _buildQuestCard(
            emoji: '👁️',
            title: 'Eye Contact Challenge',
            description: 'First one to look away buys dinner.',
            time: '30 sec',
            reward: '25',
            difficulty: 'Easy',
            difficultyGradient: [AppColors.emerald400, AppColors.teal500],
            isLocked: false,
          ),
          const SizedBox(height: 16),

          _buildQuestCard(
            emoji: '💭',
            title: 'The Vulnerability Dare',
            description: 'Share one fear you\'ve never said out loud.',
            time: '10 min',
            reward: '50',
            difficulty: 'Medium',
            difficultyGradient: [AppColors.amber400, AppColors.orange500],
            isLocked: false,
          ),
          const SizedBox(height: 16),

          _buildQuestCard(
            emoji: '🌙',
            title: 'Midnight Adventure',
            description: 'Leave the house right now. No plan.',
            time: '1 hour',
            reward: '100',
            difficulty: 'Hard',
            difficultyGradient: [AppColors.rose400, AppColors.pink500],
            isLocked: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: AppColors.playGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.rose500.withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ],
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds)
            .then()
            .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1), duration: 2.seconds),

        // Level badge
        Positioned(
          top: -8,
          right: -8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, AppColors.gray100],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.rose400,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              'Level 7',
              style: TextStyle(
                color: AppColors.rose600,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
        ),

        // XP badge
        Positioned(
          bottom: -8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.amber400, AppColors.orange500],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.amber500.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  '245 XP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: AppColors.playGradient,
          ).createShader(bounds),
          child: const Text(
            'Intimacy Arena',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose your connection quest',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQuestCard({
    required String emoji,
    required String title,
    required String description,
    required String time,
    required String reward,
    required String difficulty,
    required List<Color> difficultyGradient,
    required bool isLocked,
  }) {
    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: isLocked
                            ? LinearGradient(
                                colors: [AppColors.gray700, AppColors.gray800],
                              )
                            : LinearGradient(
                                colors: AppColors.playGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        boxShadow: isLocked
                            ? null
                            : [
                                BoxShadow(
                                  color: AppColors.rose500.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                      ),
                      child: Stack(
                        children: [
                          if (!isLocked)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          Center(
                            child: isLocked
                                ? Icon(
                                    Icons.lock,
                                    color: AppColors.gray400,
                                    size: 32,
                                  )
                                : Text(
                                    emoji,
                                    style: const TextStyle(fontSize: 32),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Title and difficulty
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: difficultyGradient,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  difficulty,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.gray300,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Time and reward
                Row(
                  children: [
                    Text(
                      '⏱️ $time',
                      style: TextStyle(
                        color: AppColors.gray400,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '✨ $reward XP',
                      style: TextStyle(
                        color: AppColors.amber400,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                if (!isLocked) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColors.playGradient,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.rose500.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Start Quest',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

