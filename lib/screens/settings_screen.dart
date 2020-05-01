import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsScreen extends StatefulWidget {
  final BuildContext context;
  const SettingsScreen({Key key, this.context}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _metricValue = false;
  String _fahcel = 'Fahrenheit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: colorGrad),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _fahcel,
                      style: TextStyle(fontSize: 18, color: white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PlatformSwitch(
                          value: _metricValue,
                          onChanged: (bool bValue) =>
                              setState(() => changeMetricValue(bValue)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainTheme,
        elevation: 0.0,
        flexibleSpace: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(color: red),
        ),
      ),
    );
  }

  changeMetricValue(bool bValue) {
    _metricValue = bValue;
    if (bValue) {
      _fahcel = 'Fahrenheit';
    } else {
      _fahcel = 'Celsius';
    }
  }
}
