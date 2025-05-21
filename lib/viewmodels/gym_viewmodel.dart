import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/gym_membership.dart';
import 'package:mojtrsat/data/repositories/gym_repository.dart';

class GymViewModel extends StateNotifier<AsyncValue<GymMembership?>> {

  final GymRepository gymRepository;

  GymViewModel(this.gymRepository) : super(const AsyncValue.loading()) {
    fetchGymMembership();
  }

  // Method to fetch gym membership details
  Future<void> fetchGymMembership() async {
    try {
      
      state = const AsyncValue.loading();
      final gymMembership = await gymRepository.getGymDetails();

      state = AsyncValue.data(gymMembership);
    } catch (e, st) {
      print('Error fetching gym membership: $e');
      state = AsyncValue.error(e, st);
    }
  }

  // Method to create an empty gym membership
  // This is used when a user signs up and we want to create an empty membership
  Future<void> createEmptyMembership(GymMembership membership) async {
    try {
      await gymRepository.addGymMembership(membership);
      state = AsyncValue.data(membership);
    } catch (e,st) {
      print('Error creating empty membership: $e');
      state = AsyncValue.error(e,st);
    }
  }

  // Method to add a gym membership when a user was already registered in gym, but dropped out and now wants to rejoin
  Future<void> addGymMembershipAgain(String membershipType, int membershipLength) async {

    try {
      
      await gymRepository.addGymMembershipAgain(membershipType, membershipLength);
      final newGymMembership = await gymRepository.getGymDetails();
      // Update the state with the new gym membership details
      state = AsyncValue.data(newGymMembership);        
      
    } catch (e) {
      print('Error updating membership: $e');
    }
  }

  // Method to remove a gym membership
  // This is used when a user wants to drop out of the gym
  Future<void> removeGymMembership() async {

  try {
    await gymRepository.removeGymMembership();
    await fetchGymMembership();
  } catch (e) {
    print('Error removing membership: $e');
  }
}

}
