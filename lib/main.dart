import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:number_trainer/I18n/my_localizations.dart';
import 'components/RecognizerScreen/recognizer_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //localization-related factories
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          const MyLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //      GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('es', ''), // Spanish, no country code
          // ... other locales the app supports
        ],
        //onGenerateTitle defaults to title if the function don't generate a valid String
        onGenerateTitle: (BuildContext context) =>
            MyLocalizations.of(context).title,
        title: 'Números',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.yellow,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeWidget() //MyLocalizations.of(context).title) //MyHomePage(),
        );
  }
}

//the next class is only a wrapper to call RecognizerScreen passing a localized title
//it can not be done from the Material app of the above, because if we do so, we are
//going to get a null reference exception in the MyLocalizations call (context is not yet available)
class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RecognizerScreen(
      title: MyLocalizations.of(context).title,
    ));
  }
}

void main() {
  runApp(MyApp());
}
