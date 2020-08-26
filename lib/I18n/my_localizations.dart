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
      'could_you_draw_a_number_': 'Could you draw a number ',
      'zero': 'zero',
      'one': 'one',
      'two': 'two',
      'three': 'three',
      'four': 'four',
      'five': 'five',
      'six': 'six',
      'seven': 'seven',
      'eight': 'eight',
      'nine': 'nine',
      'excelent': 'Excelent!',
      'try_again': 'mmmm...not quite, try to draw a',
    },
    'es': {
      'title': 'Reconocedor de números',
      'draw_a_number_in_the_box': 'Dibuja el numero en la caja de abajo',
      'let_me_guess': 'Déjame adivinar...',
      'the_number_you_draw_is': 'El número que escribiste es ',
      'could_you_draw_a_number_': 'Puedes escribir el número ',
      'zero': 'cero',
      'one': 'uno',
      'two': 'dos',
      'three': 'tres',
      'four': 'cuatro',
      'five': 'cinco',
      'six': 'seis',
      'seven': 'siete',
      'eight': 'ocho',
      'nine': 'nueve',
      'excelent': 'Excelente!',
      'try_again': 'mmmm...no exactamente, intenta nuevamente escribir el ',
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

  String get couldYouDrawANumber_ {
    return _localizedValues[locale.languageCode]['could_you_draw_a_number_'];
  }

  String get zero {
    return _localizedValues[locale.languageCode]['zero'];
  }

  String get one {
    return _localizedValues[locale.languageCode]['one'];
  }

  String get two {
    return _localizedValues[locale.languageCode]['two'];
  }

  String get three {
    return _localizedValues[locale.languageCode]['three'];
  }

  String get four {
    return _localizedValues[locale.languageCode]['four'];
  }

  String get five {
    return _localizedValues[locale.languageCode]['five'];
  }

  String get six {
    return _localizedValues[locale.languageCode]['six'];
  }

  String get seven {
    return _localizedValues[locale.languageCode]['seven'];
  }

  String get eight {
    return _localizedValues[locale.languageCode]['eight'];
  }

  String get nine {
    return _localizedValues[locale.languageCode]['nine'];
  }

  String get excelent {
    return _localizedValues[locale.languageCode]['excelent'];
  }

  String get tryAgain {
    return _localizedValues[locale.languageCode]['try_again'];
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
