import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/gradient_button.dart';

class MediatorTab extends StatelessWidget {
  const MediatorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          // Background radial gradient
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.blue500.withOpacity(0.15),
                      Colors.transparent,
                    ],
                    radius: 0.8,
                  ),
                ),
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

          _buildProtocolCard(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Ping effect
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue400.withOpacity(0.3),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(begin: const Offset(1, 1), end: const Offset(1.3, 1.3), duration: 2.seconds)
            .fade(begin: 0.3, end: 0.0),

        // Main circle
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: AppColors.mediatorGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.blue500.withOpacity(0.5),
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
                  Icons.shield,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ],
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
            colors: AppColors.mediatorGradient,
          ).createShader(bounds),
          child: const Text(
            'Peace Protocol',
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
          'Guardian mode for when things get heated',
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

  Widget _buildProtocolCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Step 1
              _buildStepCard(
                stepNumber: 1,
                title: 'Nervous System Reset',
                description:
                    'Both of you pause for 20 seconds. One deep breath in, one long breath out. No talking. Just reset.',
              ),
              const SizedBox(height: 16),

              // Step 2
              _buildStepCard(
                stepNumber: 2,
                title: 'Mirror, Don\'t Defend',
                description:
                    'Whoever spoke last, have the other partner repeat what they heard in their own words before responding. No fixing. Just show you understood.',
              ),
              const SizedBox(height: 16),

              // Step 3
              _buildStepCard(
                stepNumber: 3,
                title: 'One Need, Not Ten',
                description:
                    'Each of you name just one thing you need in this moment. Not a life review — just tonight.',
              ),
              const SizedBox(height: 32),

              // Activate button
              GradientButton(
                text: 'Activate Live Guidance',
                onPressed: () {},
                gradientColors: AppColors.mediatorGradient,
                borderRadius: 20,
              ),
              const SizedBox(height: 16),

              // Footer text
              Text(
                'Use this when voices rise, eyes glaze, or one of you starts to shut down.',
                style: TextStyle(
                  color: AppColors.gray500,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required int stepNumber,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.blue500.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.blue400.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step $stepNumber — $title',
            style: TextStyle(
              color: AppColors.blue300,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: AppColors.gray200,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

