import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/data/models/news_article.dart';
import 'package:mojtrsat/data/models/student.dart';
import 'package:mojtrsat/data/repositories/canteen_repository.dart';
import 'package:mojtrsat/data/repositories/news_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CanteenViewModel extends StateNotifier<AsyncValue<Canteen?>> {
  final CanteenRepository repository;

  CanteenViewModel(this.repository) : super(const AsyncValue.loading()) {
    fetchCanteen();
  }

  // Method to fetch canteen data
  // This method will be called when the app starts
  Future<void> fetchCanteen() async {
    state = const AsyncValue.loading();

    try {
      final canteen = await repository.getCanteen();
      state = AsyncValue.data(canteen);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// This class will handle the data layer for the news articles
// It will interact with the database to fetch news articles

class NewsViewModel extends StateNotifier<List<NewsArticle>> {
  final NewsRepository repository;

  //constructor for initializing initial state of class NewsViewModel to empty list (no news at beginning)
  NewsViewModel(this.repository) : super([]);

  Future<void> getNews() async {
    try {
      final news = await repository.fetchNews();
      state = news;
    } catch (e) {
      print("Greska:  $e");
    }
  }
}

// This class will handle the data layer for the student information
// It will interact with the database to fetch student information

class StudentViewModel extends StateNotifier<AsyncValue<Student?>> {
  final SupabaseClient _supabase;

  StudentViewModel(this._supabase) : super(const AsyncValue.loading()) {
    getStudentInfo();
  }

  Future<void> getStudentInfo() async {
    try {
      final response =
          await _supabase.from('users').select().eq('name', 'Bernard');
      if (response.isNotEmpty) {
        final student = Student.fromJson(response.first);
        //update state with student data
        state = AsyncValue.data(student);
      } else {
        print(response);
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
