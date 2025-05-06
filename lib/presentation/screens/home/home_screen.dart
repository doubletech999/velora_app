import 'package:flutter/material.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';
import 'widgets/featured_paths_section.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/suggested_adventures.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحباً في Velora',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'اكتشف جمال فلسطين',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    const SearchBarWidget(),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: FeaturedPathsSection(),
            ),
            const SliverToBoxAdapter(
              child: SuggestedAdventures(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}