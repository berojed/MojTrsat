import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/news_article.dart';
import 'package:mojtrsat/data/repositories/news_repository.dart';
import 'package:mojtrsat/providers/providers.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return NewsRepository(supabaseClient);
});

final newsProvider = FutureProvider<List<NewsArticle>>((ref) async {
  final newsRepository = ref.watch(newsRepositoryProvider);
  return newsRepository.fetchNews();
});
