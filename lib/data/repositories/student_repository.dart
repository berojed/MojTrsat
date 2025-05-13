import 'package:mojtrsat/data/models/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// This class will handle the data layer for the student information
// It will interact with the database to fetch student information
class StudentRepository {
  final SupabaseClient _supabaseClient;

  StudentRepository(this._supabaseClient);

  // TODO: Implement the method to fetch current user student information from the database
  Future<Student?> getStudentInfo() async {
    final response = await _supabaseClient
        .from('users')
        .select()
        .limit(1)
        .single();

    if (response.isEmpty) {
      throw Exception('Failed to fetch student info: ${response.toString()}');
    }

    return Student.fromJson(response);
  }
}