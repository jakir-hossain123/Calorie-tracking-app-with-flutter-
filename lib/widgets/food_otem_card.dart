import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../utils/app_colors.dart';

class FoodItemCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onDelete;

  const FoodItemCard({
    super.key,
    required this.food,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: const Icon(
            Icons.restaurant,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          food.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${food.calories} kcal',
          style: const TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}