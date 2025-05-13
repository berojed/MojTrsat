// This class will handle the data layer for the news articles
// It will interact with the database to fetch news articles
// and provide it to the rest of the application.

import 'package:mojtrsat/data/models/news_article.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsRepository {
  final SupabaseClient _supabaseClient;

  NewsRepository(this._supabaseClient);

  Future<List<NewsArticle>> fetchNews() async {
    final response = await _supabaseClient
        .from('articles_svjetionik')
        .select();
 

   if (response.isEmpty) {
      return [];
    }

    final List<dynamic> data = response;
    return data.map((item) => NewsArticle.fromJson(item)).toList();
  }
}