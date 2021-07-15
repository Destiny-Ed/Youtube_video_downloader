import 'package:flutter/material.dart';
import 'package:youtube_downloader/Screens/browser_page.dart';
import 'package:youtube_downloader/Screens/paste_link_page.dart';

import '../getSharedData.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentIndex = 0;

  String data = "";

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    DataClass().sharedData().then((value) {
      setState(() {
        if (value.contains("https://youtu.be")) {
          data = "";
          data = value;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      DataClass().sharedData().then((value) {
        setState(() {
          // _textController.text = "";
          print("Dependency changed ======================== $value");

          if (value.contains("https://youtu.be")) {
            data = "";
            data = value;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text("Youtube downloader"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: bodyPages(data)[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        items: items,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }

  List<Widget> bodyPages(String data) {
    return <Widget>[
      PasteLinkPage(data: data),
      BrowserPage(data: data),
    ];
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.paste), label: "Paste Link"),
    BottomNavigationBarItem(icon: Icon(Icons.network_cell), label: "Browser"),
  ];
}
