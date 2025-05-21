import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mojtrsat/core/errors/auth_failure.dart';
import 'package:mojtrsat/data/repositories/auth_repository.dart';
import 'package:mojtrsat/viewmodels/auth_viewmodels/base_auth_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends BaseAuthViewModel {

  LoginViewModel(AuthRepository authRepository)
      : super(authRepository, authRepository.supabaseClient);


  // Method to handle user login
  Future<Either<AuthFailure, bool>> login(String email, String password) async {
    isLoading = false;
    errorMessage = null;
    state = true;

    try {
      final response = await authRepository.signIn(email, password);
      final success = response?.user != null;
      if(success)
      {
        return right(true);
      }
      else
      {
        return left(const InvalidCredentialsFailure());
      }
    }
    on SocketException {
      return left(const NetworkFailure());
    }
    on PostgrestException catch (e) {
      return left(UnknownFailure(e.message));
    }

    catch (e) {
      return left(UnknownFailure(e.toString()));
    }
    finally {
      isLoading = false;
    }
  }


  // Method to handle reset of the password 
  Future <void> resetPassword(String email) async {
    try {
      await authRepository.resetPassword(email);
    } on SocketException {
      throw const NetworkFailure();
    } on PostgrestException catch (e) {
      throw UnknownFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<bool> userExists() async {
    try {
      final userID = supabaseClient.auth.currentUser?.id;
      if (userID == null) {
        return false;
      }
      final response = await authRepository.userExists(userID);
      return response;
    } on SocketException {
      throw const NetworkFailure();
    } on PostgrestException catch (e) {
      throw UnknownFailure(e.message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }



  

}
