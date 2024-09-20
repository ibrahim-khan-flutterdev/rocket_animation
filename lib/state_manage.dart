import 'package:flutter/material.dart';

class MyAnimation with ChangeNotifier {
  late AnimationController rocketController;
  late AnimationController textController;
  late Animation<double> rocketAnimation;
  late Animation<double> textAnimation;
  bool showBlast = false;
  bool showText = false;
  bool isLoading = false;
  init(TickerProvider vsync) {
    rocketController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: vsync,
    );

    textController = AnimationController(
      duration: Duration(seconds: 18),
      vsync: vsync,
    );

    rocketAnimation = Tween<double>(begin: 0, end: 1).animate(rocketController);

    textAnimation = CurvedAnimation(
      parent: textController,
      curve: Curves.easeInOut,
    );
    startAnimationLoop();
  }

  void startAnimationLoop() {
    rocketController.forward().whenComplete(() {
      showBlast = true;
      notifyListeners();

      textController.forward();

      // Show text after the blast completes and turn off the blast effect
      Future.delayed(Duration(seconds: 8), () {
        showText = true;
        showBlast = false;
        notifyListeners();

        // Reset and start the loop again after 1 minute
        Future.delayed(Duration(minutes: 1), () {
          showText = false;
          notifyListeners();
          rocketController.reset();
          textController.reset();
          startAnimationLoop();
        });
      });
    });
  }

  @override
  void dispose() {
    rocketController.dispose();
    textController.dispose();
    super.dispose();
  }
}
