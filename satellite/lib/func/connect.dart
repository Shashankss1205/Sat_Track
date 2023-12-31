  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
  import 'package:satellite/func/device.dart';
  import 'package:permission_handler/permission_handler.dart';

  class SelectBondedDevicePage extends StatefulWidget {
    /// If true, on page start there is performed discovery upon the bonded devices.
    /// Then, if they are not available, they would be disabled from the selection.
    final bool checkAvailability;
    final Function onChatPage;

    const SelectBondedDevicePage(
        {super.key, this.checkAvailability = true, required this.onChatPage});

    @override
    _SelectBondedDevicePage createState() => _SelectBondedDevicePage();
  }

  enum _DeviceAvailability {
    no,
    maybe,
    yes,
  }

  class _DeviceWithAvailability extends BluetoothDevice {
    BluetoothDevice device;
    _DeviceAvailability availability;
    int? rssi;
    var address;

    _DeviceWithAvailability(this.address, this.device, this.availability, [this.rssi]) : super(address: address
    );
  }

  class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
    List<_DeviceWithAvailability>? devices;

    // Availability
    late StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
    late bool _isDiscovering;

    _SelectBondedDevicePage();
    void _initializeDevices() {
      _isDiscovering = widget.checkAvailability;

      if (_isDiscovering) {
        _startDiscovery();
      }

      // Fetch bonded devices
      FlutterBluetoothSerial.instance
          .getBondedDevices()
          .then((List<BluetoothDevice> bondedDevices) {
        setState(() {
          devices = bondedDevices
              .map((device) => _DeviceWithAvailability(
            device.address,
            device,
            widget.checkAvailability
                ? _DeviceAvailability.maybe
                : _DeviceAvailability.yes,
          ))
              .toList();
        });
      });
    }
    Future<void> requestBluetoothPermissions() async {
      // Request BLUETOOTH_CONNECT permission
      var permissionStatus = await Permission.bluetoothConnect.request();
      if (permissionStatus == PermissionStatus.granted) {
        // Permission granted, proceed with Bluetooth operations
        _initializeDevices();
      } else {
        // Handle permission denial
        // You might want to display an error message or prompt the user to enable the permission
      }
    }
    @override
    void initState() {
      super.initState();
      requestBluetoothPermissions();
      _isDiscovering = widget.checkAvailability;

      if (_isDiscovering) {
        _startDiscovery();
      }


      // Setup a list of the bonded devices
      FlutterBluetoothSerial.instance
          .getBondedDevices()
          .then((List<BluetoothDevice> bondedDevices) {
        setState(() {
          devices = bondedDevices
              .map(
                (device) => _DeviceWithAvailability(
                  device.address,
              device,
              widget.checkAvailability
                  ? _DeviceAvailability.maybe
                  : _DeviceAvailability.yes,
            ),
          )
              .toList();
        });
      });
    }

    void _restartDiscovery() {
      setState(() {
        _isDiscovering = true;
      });

      _startDiscovery();
    }

    void _startDiscovery() {
      _discoveryStreamSubscription =
          FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
            setState(() {
              Iterator i = devices!.iterator;
              while (i.moveNext()) {
                var device = i.current;
                if (device.device == r.device) {
                  device.availability = _DeviceAvailability.yes;
                  device.rssi = r.rssi;
                }
              }
            });
          });

      _discoveryStreamSubscription.onDone(() {
        setState(() {
          _isDiscovering = false;
        });
      });
    }

    @override
    void dispose() {
      // Avoid memory leak (`setState` after dispose) and cancel discovery
      _discoveryStreamSubscription.cancel();

      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      List<BluetoothDeviceListEntry> list = devices!
          .map(
            (_device) => BluetoothDeviceListEntry(
          device: _device.device,
          // rssi: _device.rssi,
          // enabled: _device.availability == _DeviceAvailability.yes,
          onTap: () {
            widget.onChatPage(_device.device);
          },
        ),
      )
          .toList();
      return ListView(
        children: list,
      );
    }
  }
