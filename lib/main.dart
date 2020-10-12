import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - flutter/issues/#67915',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter - flutter/issues/#67915'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _keyboardListenerFocus = FocusNode();
  String _keyName = 'N/A';
  bool _listenerActive = false;

  @override
  void initState() {
    super.initState();

    _keyboardListenerFocus.addListener(() {
      setState(() => _listenerActive = _keyboardListenerFocus.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Plain TextField:'),
            Container(width: 200, child: TextField()),
            SizedBox(height: 50),
            Text('Tap the green container to focus the RawKeyboardListener:'),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () => _keyboardListenerFocus.requestFocus(),
              child: Container(
                width: 200,
                height: 100,
                color: _listenerActive ? Colors.lightGreen : Colors.green,
                alignment: Alignment.center,
                child: RawKeyboardListener(
                  focusNode: _keyboardListenerFocus,
                  onKey: (keyEvent) => setState(
                      () => _keyName = keyEvent.data.logicalKey.debugName),
                  child: _listenerActive
                      ? Text(
                          'Listener focused!\nPress some keys.\nkeyName = $_keyName',
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Listener not focused\nTap here to focus\n',
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keyboardListenerFocus.dispose();

    super.dispose();
  }
}
