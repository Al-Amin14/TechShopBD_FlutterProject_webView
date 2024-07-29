import 'package:flutter/services.dart';

class Utils{
  void Remove_deafautlNavbar(){
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }
}