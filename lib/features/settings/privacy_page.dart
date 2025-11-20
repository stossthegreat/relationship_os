import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
                        'Privacy Policy',
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
                                'Our Commitment to Privacy',
                                'At RelationshipOS, your privacy is our top priority. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '1. Information We Collect',
                                'Personal Data: We may collect personally identifiable information such as your name, partner\'s name, and relationship milestones that you voluntarily provide.\n\n'
                                'Usage Data: We collect information about how you interact with the app, including features used, quest completion, and app performance data.\n\n'
                                'Device Data: We may collect information about your device, including device type, operating system, and unique device identifiers.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '2. How We Use Your Information',
                                'We use the information we collect to:\n\n'
                                '• Provide and maintain our service\n'
                                '• Personalize your experience\n'
                                '• Analyze usage patterns to improve the app\n'
                                '• Send you notifications (if enabled)\n'
                                '• Respond to your requests and support needs',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '3. Data Storage',
                                'Your personal data is stored locally on your device. We use industry-standard encryption to protect your data. We do not store your personal relationship data on external servers.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '4. Data Sharing',
                                'We do not sell, trade, or rent your personal information to third parties. We may share aggregated, anonymized data for research or marketing purposes.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '5. Your Rights',
                                'You have the right to:\n\n'
                                '• Access your personal data\n'
                                '• Correct inaccurate data\n'
                                '• Request deletion of your data\n'
                                '• Opt-out of notifications\n'
                                '• Export your data',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '6. Children\'s Privacy',
                                'RelationshipOS is intended for users aged 18 and older. We do not knowingly collect information from children under 18.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '7. Security',
                                'We implement appropriate technical and organizational measures to protect your personal data. However, no method of transmission over the internet is 100% secure.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '8. Changes to This Policy',
                                'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
                              ),
                              const SizedBox(height: 20),

                              _buildSection(
                                '9. Contact Us',
                                'If you have questions about this Privacy Policy, please contact us at:\n\n'
                                'Email: privacy@relationshipos.app\n'
                                'Website: www.relationshipos.app',
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

