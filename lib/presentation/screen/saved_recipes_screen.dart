import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/saved_recipe_provider.dart';
import '../widget/recipe_list_tile.dart';
import '../../core/theme/app_colors.dart';

class SavedRecipesScreen extends StatefulWidget {
  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  bool showUntried = true;

  @override
  Widget build(BuildContext context) {
    final savedProvider = context.watch<SavedRecipeProvider>();
    final recipes = showUntried
        ? savedProvider.untriedRecipes
        : savedProvider.madeRecipes;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 16,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saved Recipes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showUntried = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: showUntried
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: showUntried
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Untried",
                            style: TextStyle(
                              color: showUntried
                                  ? Colors.white
                                  : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showUntried = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !showUntried
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: !showUntried
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Made it",
                            style: TextStyle(
                              color: !showUntried
                                  ? Colors.white
                                  : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: recipes.isEmpty
                  ? Center(
                      child: Text(
                        showUntried
                            ? "No untried saved recipes yet."
                            : "No completed recipes yet.",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeListTile(
                          recipe: recipes[index],
                          isSaved: true,
                          onBookmarkTap: () =>
                              savedProvider.toggleSave(recipes[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
