import 'package:flutter/material.dart';

class appbarrow extends StatelessWidget {
  final controller;
  const appbarrow({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                await controller.goBack();
              } else {
                SnackBar(content: Text('Not back history',style: TextStyle(fontFamily: 'Schyler'),));
              }
              return;
            },
            icon: Icon(Icons.arrow_back_ios_rounded, size: 30)),
        IconButton(
            onPressed: () async {
              if (await controller.canGoForward()) {
                await controller.goForward();
              } else {
               SnackBar(content: Text('Not forward history',style: TextStyle(fontFamily: 'Schyler'),));
              }
              return;
            },
            icon: Icon(Icons.arrow_forward_ios_rounded, size: 30)),
        IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: Icon(
              Icons.replay_circle_filled_rounded,
              size: 30,
            )),
      ],
    );
  }
}
