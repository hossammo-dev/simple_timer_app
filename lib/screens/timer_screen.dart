import 'package:flutter/material.dart';
import 'package:simple_timer_app/widgets/timer_painter.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerAsString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${(duration.inHours).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int secs = 0;
  var mins = 25;
  int hrs = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: secs, minutes: mins, hours: hrs),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COUNT DOWN'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: TimerPainter(
                                animation: animationController,
                                backgroundColor: Colors.white,
                                color: Theme.of(context).indicatorColor,
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'count down'.toUpperCase(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            AnimatedBuilder(
                              animation: animationController,
                              builder: (context, child) {
                                return Text(
                                  timerAsString,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: 60,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    elevation: 5.0,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Icon(animationController.isAnimating
                            ? Icons.pause
                            : Icons.play_arrow);
                      },
                    ),
                    onPressed: () {
                      if (animationController.isAnimating) {
                        animationController.stop();
                      } else {
                        animationController.reverse(
                          from: (animationController.value == 0.0)
                              ? 1.0
                              : animationController.value,
                        );
                      }
                    },
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('mins'),
                        Container(
                          width: 70,
                          margin: EdgeInsets.only(top: 8.0),
                          child: TextField(
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onSubmitted: (value) {
                              setState(() {
                                // mins = int.parse('$value');
                                mins = value as int;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    elevation: 5.0,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Icon(Icons.restore);
                      },
                    ),
                    onPressed: () {
                      animationController.reset();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
