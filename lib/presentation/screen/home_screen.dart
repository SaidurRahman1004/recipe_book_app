import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/recipe_provider.dart';
import '../provider/saved_recipe_provider.dart';
import '../widget/recipe_card.dart';
import '../widget/recipe_list_tile.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ['All', 'Breakfast', 'Lunch', 'Dinner'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final savedProvider = context.watch<SavedRecipeProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        toolbarHeight: 80,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ), // Placeholder for user profile
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  'Omar Calzoni',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Icon(Icons.search, color: Colors.black, size: 20),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 20,
              ),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories
                          .map(
                            (cat) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(cat),
                                selectedColor: AppColors.primary,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.grey[200]!),
                                ),
                                labelStyle: TextStyle(
                                  color: provider.selectedCategory == cat
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: provider.selectedCategory == cat
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                showCheckmark: false,
                                selected: provider.selectedCategory == cat,
                                onSelected: (bool selected) {
                                  if (selected) provider.selectCategory(cat);
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Popular Recipes",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.popularRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = provider.popularRecipes[index];
                        return RecipeCard(
                          recipe: recipe,
                          isSaved: savedProvider.isSaved(recipe.id),
                          onBookmarkTap: () => savedProvider.toggleSave(recipe),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Recipes Of The Weeks",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.weeklyRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = provider.weeklyRecipes[index];
                      return RecipeListTile(
                        recipe: recipe,
                        isSaved: savedProvider.isSaved(recipe.id),
                        onBookmarkTap: () => savedProvider.toggleSave(recipe),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
