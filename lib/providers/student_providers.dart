import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/student.dart';
import 'package:mojtrsat/data/repositories/student_repository.dart';
import 'package:mojtrsat/providers/providers.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return StudentRepository(supabaseClient);
});

final studentProvider = FutureProvider<Student?>((ref) async {
  final studentRepository = ref.watch(studentRepositoryProvider);
  return studentRepository.getStudentInfo();
});
