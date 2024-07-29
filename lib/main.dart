import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:snackbar/snackbar.dart';
import 'package:techshopbd/ui_folder/appbar_row.dart';
import 'package:techshopbd/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WebViewController controller;
  var prog = 0;
  int ind = 0;
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onProgress: (progress) {
        setState(() {
          prog = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          prog = 0;
        });
      }))
      ..loadRequest(
        Uri.parse('https://techshopbd.com/'),
      );
  }

  calling_back_fr(int ind) {
    calling_back_second(ind);
  }
  calling_back_second(int ind) async {
    if (ind == 2) {
      controller.reload();
    } else if (ind == 1) {
      if (await controller.canGoForward()) {
        await controller.goForward();
      } else
        SnackBar(content: Text('Not have forward history'));
      return;
    } else if (ind == 0) {
      if (await controller.canGoBack()) {
        await controller.goBack();
      } else {
        snack('Not back history found');
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils().Remove_deafautlNavbar();
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 240, 228, 228),
      //   toolbarHeight: 50,
        // title: Text(
        //   'Buy Goods',
        //   style: TextStyle(fontFamily: 'Schyler'),
        // ),
        // actions: [
          // appbarrow(
          //   controller: controller,
          // ),
      //   ],
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (prog > 0 && prog < 100)
              LinearProgressIndicator(
                // value: prog * 1.0,
                color: Colors.black,
                minHeight: 5,
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: height*0.1,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
              label: 'Go Back'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
              ),
              label: 'Go Forward'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.replay_circle_filled_outlined,
                size: 30,
              ),
              label: 'Reload'),
        ],
        currentIndex: ind,
        onTap: (index) {
          setState(() {
            ind = index;
            calling_back_fr(ind);
          });
        },
      ),
    );
  }
}