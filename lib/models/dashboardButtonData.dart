import 'package:flutter/material.dart';

class DashboardButtonData {
  final String title;
  final IconData icon;
  final Function onPressed;
  final bool hasNotification;
  final IconData notificationIcon;
  final Color notificationIconColor;
  final bool disabled;

  DashboardButtonData({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.hasNotification = false,
    this.notificationIcon = Icons.error,
    this.notificationIconColor = Colors.red,
    this.disabled = false,
  });
}
