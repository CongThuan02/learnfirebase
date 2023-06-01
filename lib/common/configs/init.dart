
import '../storage/_localStorage.dart';
import 'service_location.dart';

Future<void> initApp() async {
  NavigationService().setupNavigator();
  await LocalStorage.init();
}
