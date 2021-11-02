

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarMessage {

  static getSnackbarMessage(String message){
     Get.snackbar('', 'message',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(seconds: 1),
        isDismissible: false,
        backgroundColor: Colors.black54,
        messageText: Row(
          children: [
            Text(
              message,
              style:const TextStyle(color: Colors.white),
            )
          ],
        ),
     //   margin:const EdgeInsets.symmetric()
     );

   }
}