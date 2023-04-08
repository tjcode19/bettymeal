import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/colours.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _showFab = true;
  bool _isElevated = true;
  bool _isVisible = true;

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab = value;
    });
  }

  void _onElevatedChanged(bool value) {
    setState(() {
      _isElevated = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        backgroundColor: AppColour(context).primaryColour,
      ),
      body: Column(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Floating Action Button'),
            value: _showFab,
            onChanged: _onShowFabChanged,
          ),
          SwitchListTile(
            title: const Text('Bottom App Bar Elevation'),
            value: _isElevated,
            onChanged: _onElevatedChanged,
          ),
          // Expanded(
          //   child: ListView(
          //     controller: _controller,
          //     children: items.toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}