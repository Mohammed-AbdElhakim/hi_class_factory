// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dark_mode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "email_incorrect": MessageLookupByLibrary.simpleMessage(
            "The email format is incorrect."),
        "enter_password":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "least_characters": MessageLookupByLibrary.simpleMessage(
            "It must be at least 6 characters long."),
        "light_mode": MessageLookupByLibrary.simpleMessage("Light Mode"),
        "login": MessageLookupByLibrary.simpleMessage("Sign in"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "required_field":
            MessageLookupByLibrary.simpleMessage("Required field"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "welcome_back": MessageLookupByLibrary.simpleMessage("Welcome back"),
        "welcome_back_info":
            MessageLookupByLibrary.simpleMessage("Hi Class Factory")
      };
}
