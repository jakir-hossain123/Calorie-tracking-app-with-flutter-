import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/food_provider.dart';
import '../utils/app_colors.dart';

import '../widgets/add_food_dialog.dart';
import '../widgets/calorie_samary_card.dart';
import '../widgets/food_otem_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getTodayDate() {
    final now = DateTime.now();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  String _formatCalories(double calories) {
    return calories % 1 == 0
        ? calories.toInt().toString()
        : calories.toStringAsFixed(1);
  }

  void _showAddFoodDialog(BuildContext context) {
    final currentRoute = ModalRoute.of(context);

    if (currentRoute != null && !currentRoute.isCurrent) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const AddFoodDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Calorie Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Date
              Text(
                _getTodayDate(),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // Calorie Summary
              const Text(
                'Calorie Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              Consumer<FoodProvider>(
                builder: (context, provider, child) {
                  final remaining = provider.remainingCalories;

                  return Row(
                    children: [
                      Expanded(
                        child: CalorieSummaryCard(
                          title: 'Total',
                          value:
                          '${_formatCalories(provider.totalCalories)} kcal',
                          icon: Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                      ),

                      Expanded(
                        child: CalorieSummaryCard(
                          title: 'Daily Goal',
                          value:
                          '${_formatCalories(provider.dailyGoal)} kcal',
                          icon: Icons.flag,
                          color: Colors.blue,
                        ),
                      ),

                      Expanded(
                        child: CalorieSummaryCard(
                          title: 'Remaining',
                          value: remaining >= 0
                              ? '${_formatCalories(remaining)} kcal'
                              : 'Over ${_formatCalories(remaining.abs())}',
                          icon: Icons.track_changes,
                          color: remaining >= 0
                              ? AppColors.primary
                              : AppColors.red,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Food List Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Food",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  Consumer<FoodProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        '${provider.foodList.length} Items',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Food List
              Expanded(
                child: Consumer<FoodProvider>(
                  builder: (context, provider, child) {
                    if (provider.foodList.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No food added yet!',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Tap the button below to add food.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.foodList.length,
                      itemBuilder: (context, index) {
                        final food = provider.foodList[index];

                        return FoodItemCard(
                          food: food,
                          onDelete: () {
                            provider.deleteFood(index);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddFoodDialog(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Food'),
      ),
    );
  }
}