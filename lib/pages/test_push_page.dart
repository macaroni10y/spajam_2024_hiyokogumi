// カウントアップする機能を持ったページを作る
import 'package:flutter/material.dart';

class TestPushPage extends StatelessWidget {
  int _counter = 0;
  void _incrimentCounter () {
      _counter += 1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Push Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: _incrimentCounter,
          child: Text('カウントアップ'),
        ),
      ),
    );
  }
}

