import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_works/viewmodels/search_viewmodel.dart';
import 'package:recipe_works/views/components/recipe_card.dart';

class RecipeSearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  RecipeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Works'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final query = _searchController.text;
                    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
                    searchViewModel.searchRecipes(query);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<SearchViewModel>(
              builder: (context, searchViewModel, _) {
                if (searchViewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final searchResults = searchViewModel.recipes;
                if (searchResults.isEmpty) {
                  return const Center(child: Text('No results found.'));
                }

                return ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    final recipe = searchResults[index];
                    return RecipeCard(recipe: recipe);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}