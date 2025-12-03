import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab2/screens/favorites.dart';
import 'package:mis_lab2/screens/home.dart';
import 'package:mis_lab2/screens/meals.dart';
import 'package:mis_lab2/screens/recipe.dart';
import 'package:mis_lab2/widgets/random_recipe_navigator.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _handleNotificationNavigation(RemoteMessage message) {
  if (message.data['action'] == 'random_recipe') {
    final ctx = navigatorKey.currentContext;
    if (ctx != null) {
      RandomRecipeNavigator.openRandomRecipe(ctx);
    } else {
      print("null");
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  final token = await messaging.getToken();
  print("FCM token: $token");

  runApp(const MyApp());

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      _handleNotificationNavigation(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationNavigation);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Food App'),
        "/meals": (context) => const MealsScreen(),
        "/recipe": (context) => const RecipesScreen(),
        "/favorites": (context) => const FavoritesScreen(),
      },
    );
  }
}
