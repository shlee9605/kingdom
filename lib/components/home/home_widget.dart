import 'package:flutter/material.dart';

import '/views/home/dialog.dart';

class HomeBodySheet extends StatefulWidget {
  const HomeBodySheet({
    super.key,
    required this.title,
    // required this.size,
  });
  final String title;
  // final int size;

  @override
  HomeBodySheetState createState() => HomeBodySheetState();
}

class HomeBodySheetState extends State<HomeBodySheet> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 100,
      width: 100,
      color: const Color.fromARGB(100, 255, 255, 255),
      child: InkWell(
        onTap: () {
          Modal.homeBodySheet(context, widget.title);
        },
        onHover: (value) {
          setState(() {
            isHover = value ? true : false;
          });
        },
        onLongPress: () {
          setState(() {
            isHover = isHover ? false : true;
          });
        },
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/images/sheet.jpg'),
              height: 80,
              width: 100,
              color: isHover ? const Color.fromARGB(200, 50, 50, 50) : null,
            ),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}

class HomeBodyChart extends StatefulWidget {
  const HomeBodyChart({super.key, required this.title});
  final String title;
  @override
  HomeBodyChartState createState() => HomeBodyChartState();
}

class HomeBodyChartState extends State<HomeBodyChart> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 200,
      width: 150,
      color: const Color.fromARGB(100, 255, 255, 255),
      child: InkWell(
        onTap: () {
          Modal.showModal(context);
        },
        onHover: (value) {
          setState(() {
            isHover = value ? true : false;
          });
        },
        onLongPress: () {
          setState(() {
            isHover = isHover ? false : true;
          });
        },
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/images/chart.png'),
              height: 170,
              width: 150,
              color: isHover ? const Color.fromARGB(200, 50, 50, 50) : null,
            ),
            Text(widget.title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class HomeBodyCamera extends StatefulWidget {
  const HomeBodyCamera({super.key, required this.title});
  final String title;
  @override
  HomeBodyCameraState createState() => HomeBodyCameraState();
}

class HomeBodyCameraState extends State<HomeBodyCamera> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 150,
      width: 200,
      color: const Color.fromARGB(100, 255, 255, 255),
      child: InkWell(
        onTap: () {
          Modal.homeBodyCamera(context);
        },
        onHover: (value) {
          setState(() {
            isHover = value ? true : false;
          });
        },
        onLongPress: () {
          setState(() {
            isHover = isHover ? false : true;
          });
        },
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/images/camera.png'),
              height: 120,
              width: 200,
              colorBlendMode: isHover ? BlendMode.modulate : null,
              color: isHover ? const Color.fromARGB(150, 255, 255, 255) : null,
            ),
            Text(widget.title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
