import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rocket_animationm/state_manage.dart';

import 'animait.dart'; // Your custom widget or animation file
// The provider file created above

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAnimation()),
      ],
      child: const MaterialApp(
        home: RocketAnimationScreen(),
      ),
    );
  }
}

class RocketAnimationScreen extends StatefulWidget {
  const RocketAnimationScreen({super.key});

  @override
  State<RocketAnimationScreen> createState() => _RocketAnimationScreenState();
}

class _RocketAnimationScreenState extends State<RocketAnimationScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final animationProvider = Provider.of<MyAnimation>(context, listen: false);
    animationProvider.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAnimation>(
      builder: (context, myAnimation, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (myAnimation.showBlast)
                  Lottie.asset(
                    'assets/firework.json',
                    width: 200,
                    height: 200,
                  ),
                if (myAnimation.showText)
                  FadeTransition(
                    opacity: myAnimation.textAnimation,
                    child: SlideTransition(
                      position: myAnimation.textAnimation.drive(Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset(0, 0),
                      )),
                      child: Transform.rotate(
                        angle: 5.5,
                        child: VisualView(), // Your custom text or widget
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
