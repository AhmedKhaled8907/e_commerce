import 'package:e_commerce/providers/theme_provider.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SubtitleText(
            label: 'Hi Again!',
            fontSize: 60,
          ),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Hello World',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          TitleText(label: 'label ' * 10),
          SwitchListTile(
            title:
                Text(themeProvider.getIsDarkTheme ? 'Dark Mode' : 'Light Mode'),
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
