import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'core/theme/app_colors.dart';
import 'data/datasource/recipe_remote_data_source.dart';
import 'data/repositories/recipe_repository_impl.dart';
import 'presentation/provider/recipe_provider.dart';
import 'presentation/provider/saved_recipe_provider.dart';
import 'presentation/screen/main_navigation.dart';

void main() {
  final remoteDataSource = RecipeRemoteDataSourceImpl(client: http.Client());
  final repository = RecipeRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeProvider(repository: repository),
        ),
        ChangeNotifierProvider(create: (_) => SavedRecipeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
      ),
      home: MainNavigation(),
    );
  }
}
