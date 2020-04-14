import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final BuildContext context;
  const SettingsScreen({Key key, this.context}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _metricValue = false;
  String fahcel = 'Fahrenheit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(fahcel),
              Switch(
                value: _metricValue,
                onChanged: (bool bValue) {
                  setState(
                    () {
                      _metricValue = bValue;
                      if (_metricValue) {
                        fahcel = 'Fahrenheit';
                      } else {
                        fahcel = 'Celsius';
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Settings'),
      ),
    );
  }
}
