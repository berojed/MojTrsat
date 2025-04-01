import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends StateNotifier<AsyncValue<Canteen?>> {
  final SupabaseClient _supabase;

  HomeViewModel(this._supabase) : super(const AsyncValue.loading()) {
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







































  /* bool _isLoading = false;
  String _error = '';
  List<String> _titles = [];

  bool get isLoading => _isLoading;
  String get error => _error;
  List<String> get titles => _titles;

  Future<void> fetchTodayExpense(String username, String password) async {
    _isLoading = true;
    _error = '';
    _titles = [];
    notifyListeners();

    try {
      // Launch a new browser instance
      var browser = await puppeteer.launch();
      var page = await browser.newPage();

      // Navigate to the login page
      await page.goto('https://login.aaiedu.hr/sso/module.php/core/loginuserpass',
          wait: Until.networkIdle);

      // Log in to the system
      await page.type('#username', username);
      await page.type('#password', password);
      await page.click('button[type="submit"]');
      await page.waitForNavigation(wait: Until.networkIdle);

      // Navigate to the student page
      await page.goto('https://issp.srce.hr/student', wait: Until.networkIdle);

      // Wait for the dynamic content to load
      await page.waitForSelector(
          '#mainDivContent > div:nth-child(2) > div > div > div > div > div.col-7.col-lg-8 > div:nth-child(4) > div:nth-child(3) > p.font-weight-bold.h5');

      // Extract the content
      /* _titles = await page.$$eval(
          '#mainDivContent > div:nth-child(2) > div > div > div > div > div.col-7.col-lg-8 > div:nth-child(4) > div:nth-child(3) > p.font-weight-bold.h5',
          (elements) {
        // Ensure the function returns a List<String>
        return elements.map<String>((element) => element.textContent.trim()).toList();
      }); */

      print('Count: ${_titles.length}');
      _titles.forEach((title) => print(title));

      // Close the browser
      await browser.close();
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  } */



  

