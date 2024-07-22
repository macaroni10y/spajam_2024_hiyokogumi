import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String anonymousUserId = "";
  String signedInAt = "";

  void _setup() async {
    var credential = await FirebaseAuth.instance.signInAnonymously();
    setState(() {
      anonymousUserId = credential.user!.uid;
      signedInAt = credential.user!.metadata.creationTime.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'anonymousUserId',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'cratedAt',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return Center(
                child: Container(
                    height: 300,
                    width: 300,
                    color: index == 0
                        ? CupertinoColors.systemBlue
                        : CupertinoColors.systemRed,
                    child: Center(
                      child: Text(
                          index == 0 ? anonymousUserId : signedInAt.toString()),
                    )));
          },
        );
      },
    );
  }
}
