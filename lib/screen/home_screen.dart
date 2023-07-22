import 'package:e_commerce/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hello world",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Hello world"),
          ),
          SwitchListTile(
            title:
                Text(themeProvider.getIsDarkTheme ? "dark Mode" : "Light Mode"),
            value: themeProvider.getIsDarkTheme,
            onChanged: (value) {
              themeProvider.setDarkTheme(themeValue: value);
            },
          )
        ],
      ),
    );
  }
}
