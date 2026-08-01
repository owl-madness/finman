import 'package:finman/features/categories/models/category_icon.dart';
import 'package:flutter/material.dart';

const categoryIcons = [
  // Food & Dining
  CategoryIcon(iconKey: 'restaurant', icon: Icons.restaurant),
  CategoryIcon(
    iconKey: 'fastfood',
    iconName: 'Fast Food',
    icon: Icons.fastfood,
  ),
  CategoryIcon(
    iconKey: 'local_cafe',
    iconName: 'Coffee & Tea',
    icon: Icons.local_cafe,
  ),
  CategoryIcon(
    iconKey: 'local_bar',
    iconName: 'Bar & Drinks',
    icon: Icons.local_bar,
  ),
  CategoryIcon(
    iconKey: 'shopping_cart',
    iconName: 'Groceries',
    icon: Icons.shopping_cart,
  ),

  // Transportation
  CategoryIcon(
    iconKey: 'directions_car',
    iconName: 'Car & Auto',
    icon: Icons.directions_car,
  ),
  CategoryIcon(
    iconKey: 'local_gas_station',
    iconName: 'Gas & Fuel',
    icon: Icons.local_gas_station,
  ),
  CategoryIcon(
    iconKey: 'directions_bus',
    iconName: 'Public Transit',
    icon: Icons.directions_bus,
  ),
  CategoryIcon(
    iconKey: 'flight',
    iconName: 'Travel & Flights',
    icon: Icons.flight,
  ),
  CategoryIcon(
    iconKey: 'local_taxi',
    iconName: 'Taxi & Rideshare',
    icon: Icons.local_taxi,
  ),

  // Shopping & Personal
  CategoryIcon(
    iconKey: 'shopping_bag',
    iconName: 'Shopping',
    icon: Icons.shopping_bag,
  ),
  CategoryIcon(
    iconKey: 'checkroom',
    iconName: 'Clothing',
    icon: Icons.checkroom,
  ),
  CategoryIcon(
    iconKey: 'card_giftcard',
    iconName: 'Gifts & Donations',
    icon: Icons.card_giftcard,
  ),
  CategoryIcon(
    iconKey: 'content_cut',
    iconName: 'Personal Care',
    icon: Icons.content_cut,
  ),

  // Housing & Utilities
  CategoryIcon(iconKey: 'home', iconName: 'Rent & Housing', icon: Icons.home),
  CategoryIcon(iconKey: 'bolt', iconName: 'Electricity', icon: Icons.bolt),
  CategoryIcon(
    iconKey: 'water_drop',
    iconName: 'Water',
    icon: Icons.water_drop,
  ),
  CategoryIcon(iconKey: 'wifi', iconName: 'Internet', icon: Icons.wifi),
  CategoryIcon(
    iconKey: 'phone_android',
    iconName: 'Mobile & Phone',
    icon: Icons.phone_android,
  ),
  CategoryIcon(
    iconKey: 'build',
    iconName: 'Maintenance & Repairs',
    icon: Icons.build,
  ),

  // Entertainment & Leisure
  CategoryIcon(
    iconKey: 'movie',
    iconName: 'Movies & Cinema',
    icon: Icons.movie,
  ),
  CategoryIcon(
    iconKey: 'sports_esports',
    iconName: 'Gaming',
    icon: Icons.sports_esports,
  ),
  CategoryIcon(
    iconKey: 'fitness_center',
    iconName: 'Gym & Fitness',
    icon: Icons.fitness_center,
  ),
  CategoryIcon(
    iconKey: 'music_note',
    iconName: 'Music',
    icon: Icons.music_note,
  ),
  CategoryIcon(
    iconKey: 'subscriptions',
    iconName: 'Subscriptions',
    icon: Icons.subscriptions,
  ),

  // Health & Medical
  CategoryIcon(
    iconKey: 'medical_services',
    iconName: 'Medical & Healthcare',
    icon: Icons.medical_services,
  ),
  CategoryIcon(
    iconKey: 'local_pharmacy',
    iconName: 'Pharmacy',
    icon: Icons.local_pharmacy,
  ),

  // Education & Work
  CategoryIcon(iconKey: 'school', iconName: 'Education', icon: Icons.school),
  CategoryIcon(iconKey: 'work', iconName: 'Salary & Income', icon: Icons.work),
  CategoryIcon(
    iconKey: 'laptop',
    iconName: 'Electronics & Tech',
    icon: Icons.laptop,
  ),

  // Finance & Misc
  CategoryIcon(
    iconKey: 'attach_money',
    iconName: 'Cash',
    icon: Icons.attach_money,
  ),
  CategoryIcon(
    iconKey: 'account_balance',
    iconName: 'Bank & Transfers',
    icon: Icons.account_balance,
  ),
  CategoryIcon(
    iconKey: 'credit_card',
    iconName: 'Credit Card',
    icon: Icons.credit_card,
  ),
  CategoryIcon(
    iconKey: 'trending_up',
    iconName: 'Investments',
    icon: Icons.trending_up,
  ),
  CategoryIcon(iconKey: 'pets', iconName: 'Pets', icon: Icons.pets),
  CategoryIcon(
    iconKey: 'more_horiz',
    iconName: 'Other',
    icon: Icons.more_horiz,
  ),
];

CategoryIcon? getCategoryIcon(String iconKey) {
  return categoryIcons.where((e) => e.iconKey == iconKey).firstOrNull;
}
