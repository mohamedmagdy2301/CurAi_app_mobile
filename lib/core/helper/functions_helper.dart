import 'package:flutter/material.dart';

//! Hide keyboard
void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
