import 'package:flutter/material.dart';

class CustomMarqueeWidget extends StatefulWidget {
  final Widget? child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const CustomMarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(seconds: 3),
    this.backDuration = const Duration(seconds: 1),
    this.pauseDuration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  State<CustomMarqueeWidget> createState() => _CustomMarqueeWidgetState();
}

class _CustomMarqueeWidgetState extends State<CustomMarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback(scrollMarquee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      controller: scrollController,
      child: widget.child,
    );
  }

  void scrollMarquee(_) async {
    while (scrollController.hasClients) {
      /// :  HERE MARQUEE PAUSE CONDITION
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.easeOut);
      }

      /// :  HERE MARQUEE PAUSE CONDITION
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(0.0,
            duration: widget.backDuration, curve: Curves.easeOut);
      }
    }
  }
}
