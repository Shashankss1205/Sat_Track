import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'connect.dart';
import 'led.dart';

class Blue extends StatefulWidget {
  final az,el;
  Blue({this.az, this.el});

  @override
  State<Blue> createState() => _BlueState();
}

class _BlueState extends State<Blue> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Connection'),
          ),
          body: SelectBondedDevicePage(
            onChatPage: (device1) {
              // print("HELLO");
              BluetoothDevice device = device1;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage(server: device, az: widget.az, el: widget.el,);
                  },
                ),
              );
            },
          ),
        ));
  }
}