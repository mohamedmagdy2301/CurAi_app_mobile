import 'package:flutter/material.dart';

//! Hide keyboard
void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

//! Check if the keyboard is visible
bool isKeyboardVisible() => FocusManager.instance.primaryFocus != null;
