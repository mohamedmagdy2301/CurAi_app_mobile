import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/snakbar/snackbar_helper.dart';

class UrlLauncherHelper {
  // WhatsApp launcher
  static Future<void> launchWhatsApp(context, String phoneNumber) async {
    final Uri uri = Uri.parse('https://wa.me/$phoneNumber');
    await _launchUri(uri, context);
  }

  // Phone call launcher
  static Future<void> launchPhoneCall(context, String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launchUri(uri, context);
  }

  // Email launcher (simple)
  static Future<void> launchEmail(context, String emailAddress) async {
    final Uri uri = Uri(scheme: 'mailto', path: emailAddress);
    await _launchUri(uri, context);
  }

  // Email launcher (with subject and body)
  static Future<void> composeEmail(
    context,
    String emailAddress,
    String subject,
    String body,
  ) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {'subject': subject, 'body': body},
    );
    await _launchUri(uri, context);
  }

  // SMS launcher
  static Future<void> sendSms(
    context,
    String phoneNumber, {
    String? message,
  }) async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null ? {'body': message} : null,
    );
    await _launchUri(uri, context);
  }

  // Website launcher
  static Future<void> launchWebsite(
    BuildContext context,
    String websiteUrl,
  ) async {
    if (!websiteUrl.startsWith("https://") &&
        !websiteUrl.startsWith("http://")) {
      websiteUrl = "https://$websiteUrl";
    }

    log("Launching URL: $websiteUrl");

    final Uri uri = Uri.parse(websiteUrl);
    await _launchUri(uri, context);
  }

  // Open Maps with latitude and longitude
  static Future<void> openMaps(
    context,
    double latitude,
    double longitude,
  ) async {
    final Uri uri =
        Platform.isIOS
            ? Uri(
              scheme: 'https',
              host: 'maps.apple.com',
              path: 'maps',
              queryParameters: {'q': '$latitude,$longitude'},
            )
            : Uri(
              scheme: 'https',
              host: 'www.google.com',
              path: 'maps/search/',
              queryParameters: {'api': '1', 'query': '$latitude,$longitude'},
            );
    await _launchUri(uri, context);
  }

  // Open directions in Maps (from and to locations)
  static Future<void> getDirections(
    context, {
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    final Uri uri =
        Platform.isIOS
            ? Uri(
              scheme: 'https',
              host: 'maps.apple.com',
              path: 'maps',
              queryParameters: {
                'saddr': '$startLatitude,$startLongitude',
                'daddr': '$endLatitude,$endLongitude',
              },
            )
            : Uri(
              scheme: 'https',
              host: 'www.google.com',
              path: 'maps/dir/',
              queryParameters: {
                'api': '1',
                'origin': '$startLatitude,$startLongitude',
                'destination': '$endLatitude,$endLongitude',
              },
            );
    await _launchUri(uri, context);
  }

  // General method to launch a URI
  static Future<void> _launchUri(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      showMessage(
        context,
        type: SnackBarType.error,
        message: 'Could not launch $url',
      );
    }
  }
}
