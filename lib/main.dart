import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_works/viewmodels/search_viewmodel.dart';
import 'package:recipe_works/views/recipe_search_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchViewModel>(create: (_) => SearchViewModel()),
      ],
      child: MaterialApp(
        title: 'My Recipes App',
        theme: ThemeData(
          textTheme: GoogleFonts.alataTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: Colors.red.shade200),
        ),
        home: RecipeSearchScreen(),
      ),
    );
  }
}
