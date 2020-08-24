import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Numbers',
      'draw_a_number_in_the_box': 'Please draw a number in the box below',
      'let_me_guess': 'Let me guess...',
      'the_number_you_draw_is': 'The number you draw is ',
    },
    'es': {
      'title': 'Reconocedor de números',
      'draw_a_number_in_the_box': 'Dibuja el numero en la caja de abajo',
      'let_me_guess': 'Déjame adivinar...',
      'the_number_you_draw_is': 'El número que escribiste es ',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get drawNumberInBox {
    return _localizedValues[locale.languageCode]['draw_a_number_in_the_box'];
  }

  String get letMeGuess {
    return _localizedValues[locale.languageCode]['let_me_guess'];
  }

  String get theNumberYouDrawIs {
    return _localizedValues[locale.languageCode]['the_number_you_draw_is'];
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
