import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/provider/login_provider.dart';
import 'package:todo/views/bottom_navigation_bar.dart';
import 'package:todo/views/edit_view.dart';
import 'package:todo/views/login_view.dart';
import 'package:todo/views/sign_up_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var u = FirebaseFunctions.readUser();

  print("&&&&&&&&&&&&&&&&&&&& $u");
  // await FirebaseFirestore.instance.enableNetwork();
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
    create: (context) => LoginProvider(),
    child: const ToDoApp(),
  ));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // darkTheme: darkTheme(),
      initialRoute: loginProvider.fireBaseAuthUser != null
          ? BottomNavigationBarr.routName
          : LoginScreen.routName,
      routes: {
        BottomNavigationBarr.routName: (context) => BottomNavigationBarr(),
        LoginScreen.routName: (context) => LoginScreen(),
        SignUpView.routName: (context) => SignUpView(),
        EditView.routName: (context) => EditView(),
      },
    );
  }
}
