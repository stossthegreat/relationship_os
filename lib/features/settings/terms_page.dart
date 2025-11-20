import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [
                  AppColors.purple500.withOpacity(0.15),
                  AppColors.gray950,
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Terms of Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSection(
                                'Last Updated',
                                'November 20, 2025',
                              ),
                              const SizedBox(height: 24),

                              _buildSection(
                                '1. Acceptance of Terms',
                                'By accessing and using RelationshipOS, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '2. Use License',
                                'Permission is granted to temporarily use RelationshipOS for personal, non-commercial use only. This is the grant of a license, not a transfer of title, and under this license you may not:\n\n'
                                '• Modify or copy the materials\n'
                                '• Use the materials for any commercial purpose\n'
                                '• Attempt to decompile or reverse engineer any software\n'
                                '• Remove any copyright or other proprietary notations',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '3. User Data',
                                'You retain all rights to your personal data. RelationshipOS stores data locally on your device and does not share your information with third parties without your explicit consent.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '4. Disclaimer',
                                'RelationshipOS is provided for informational and entertainment purposes. It is not a substitute for professional relationship counseling or therapy. The materials on RelationshipOS are provided on an \'as is\' basis. RelationshipOS makes no warranties, expressed or implied.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '5. Limitations',
                                'In no event shall RelationshipOS or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use RelationshipOS.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '6. Modifications',
                                'RelationshipOS may revise these terms of service at any time without notice. By using this app, you are agreeing to be bound by the then current version of these terms of service.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '7. Contact',
                                'If you have any questions about these Terms, please contact us at legal@relationshipos.app',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: AppColors.gray300,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

