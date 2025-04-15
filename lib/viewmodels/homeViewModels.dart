import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/data/models/news_article.dart';
import 'package:mojtrsat/data/models/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CanteenViewModel extends StateNotifier<AsyncValue<Canteen?>> {
  final SupabaseClient _supabase;

  CanteenViewModel(this._supabase) : super(const AsyncValue.loading()) {
    getCanteen();
  }

  Future<void> getCanteen() async {
    try {
      final response = await _supabase.from('canteen').select().eq('canteen_id', 1);
      if (response.isNotEmpty) {
        final canteen = Canteen.fromMap(response.first);
        state = AsyncValue.data(canteen);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }


}

class NewsViewModel extends StateNotifier<List<NewsArticle>> {

  final SupabaseClient _supabase;

  //constructor for initializing initial state of class NewsViewModel to empty list (no news at beginning)
  NewsViewModel(this._supabase) : super([]);

  

  Future<void> getNews() async{

    try {
      final response = await _supabase.from('articles_svjetionik').select();

      state = response.map((json) => NewsArticle.fromJson(json)).toList();
    } catch (e) 
     {
      print("Greska:  $e");
    }
  }

}


class StudentViewModel extends StateNotifier<AsyncValue<Student?>> {
  final SupabaseClient _supabase;

  StudentViewModel(this._supabase) : super(const AsyncValue.loading()) {
    getStudentInfo();
  }

  Future<void> getStudentInfo() async {
    try {
      final response=await _supabase.from('users').select().eq('name', 'Bernard'); //ovdje stavi id od trenutnog usera
      if(response.isNotEmpty){
        final student = Student.fromJson(response.first);
        //update state with student data
        state = AsyncValue.data(student);     
      }
      else{
        print(response);
    }
    }
    catch (error){
      print("Error: $error");
    }
  }



}

