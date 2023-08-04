import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomScrollViewWithBackButton extends StatefulWidget {
  final Widget child;
  const CustomScrollViewWithBackButton({
    super.key,
    required this.child,
  });

  @override
  State<CustomScrollViewWithBackButton> createState() =>
      _CustomScrollViewWithBackButtonState();
}

class _CustomScrollViewWithBackButtonState
    extends State<CustomScrollViewWithBackButton> {
  late ScrollController _scrollController;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            widget.child,
            if (_showBackToTopButton)
              Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color(0xff247297),
                  onPressed: _scrollToTop,
                  child: Icon(
                    PhosphorIcons.regular.arrowUp,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
