import 'package:flutter/material.dart';

class SiteShowView extends StatefulWidget {
  final String siteId;
  const SiteShowView({
    super.key,
    required this.siteId,
  });

  @override
  State<SiteShowView> createState() => _SiteShowViewState();
}

class _SiteShowViewState extends State<SiteShowView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
