import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/app_colors.dart';

class PathDetailsScreen extends StatefulWidget {
  final String pathId;

  const PathDetailsScreen({
    super.key,
    required this.pathId,
  });

  @override
  State<PathDetailsScreen> createState() => _PathDetailsScreenState();
}

class _PathDetailsScreenState extends State<PathDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Get path data from provider
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Image carousel
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: 3, // Replace with actual images count
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: 'https://example.com/image$index.jpg',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: WormEffect(
                          dotColor: Colors.white.withOpacity(0.5),
                          activeDotColor: Colors.white,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and location
                  Text(
                    'مسار الجليل الأعلى',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        PhosphorIcons.map_pin,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'الجليل، شمال فلسطين',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Info cards
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: PhosphorIcons.radical,
                          title: 'المسافة',
                          value: '12 كم',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _InfoCard(
                          icon: PhosphorIcons.clock,
                          title: 'المدة',
                          value: '4 ساعات',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _InfoCard(
                          icon: PhosphorIcons.chart_line,
                          title: 'الصعوبة',
                          value: 'متوسط',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'الوصف',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'مسار الجليل الأعلى هو واحد من أجمل المسارات في شمال فلسطين. يمر المسار عبر غابات وقرى فلسطينية تاريخية، ويوفر مناظر خلابة للبحر المتوسط والجبال المحيطة.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // Activities
                  Text(
                    'الأنشطة المتاحة',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ActivityChip(icon: PhosphorIcons.person_simple_walk, label: 'المشي'),
                      _ActivityChip(icon: PhosphorIcons.campfire_light, label: 'التخييم'),
                      _ActivityChip(icon: PhosphorIcons.camera, label: 'التصوير'),
                      _ActivityChip(icon: PhosphorIcons.tree, label: 'الطبيعة'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Warnings
                  Text(
                    'تحذيرات وإرشادات',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  _WarningCard(
                    'احرص على أخذ كمية كافية من الماء (لا يقل عن 3 لترات للشخص)',
                  ),
                  _WarningCard(
                    'يُنصح بالبدء في الصباح الباكر خاصة في فصل الصيف',
                  ),
                  _WarningCard(
                    'بعض المناطق قد تكون زلقة بعد المطر',
                  ),
                  const SizedBox(height: 24),

                  // Start journey button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement start journey
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'ابدأ الرحلة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActivityChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        icon,
        size: 18,
        color: AppColors.primary,
      ),
      label: Text(label),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      labelStyle: TextStyle(color: AppColors.primary),
    );
  }
}

class _WarningCard extends StatelessWidget {
  final String text;

  const _WarningCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.warning.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIcons.warning,
            color: AppColors.warning,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.warning.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on Color {
  get shade700 => null;
}