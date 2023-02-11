import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_arkamaya/model/single_user.dart';
import 'package:pt_arkamaya/provider/list_user_provider.dart';
import 'package:pt_arkamaya/ui/about_page.dart';
import 'package:pt_arkamaya/ui/create_user_page.dart';
import 'package:pt_arkamaya/ui/list_user_page.dart';
import 'package:pt_arkamaya/ui/single_user_page.dart';

import 'api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ListUserProvider(apiService: ApiService())),
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
             primary: const Color.fromRGBO(100, 92, 187, 1),
             onPrimary: Colors.white,
             secondary: Colors.lightBlue,
        ),
      ),
        initialRoute: ListPage.routeName,
        routes: {
          ListPage.routeName: (context) => ListPage(),
          SingleUserPage.routeName: (context) => SingleUserPage(
              id: ModalRoute.of(context)?.settings.arguments as String
          ),
          CreateUserPage.routeName: (context) => CreateUserPage(),
          AboutPage.routeName: (context) => AboutPage(),
        },
      )
    );
  }
}
