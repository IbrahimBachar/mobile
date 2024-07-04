import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;
  final ThemeMode themeMode;

  const HomePage({required this.onThemeChanged, required this.themeMode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Gaba Tourba',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () {
                Navigator.pushNamed(context, '/calculator');
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                themeMode == ThemeMode.light
                    ? Icons.wb_sunny
                    : themeMode == ThemeMode.dark
                    ? Icons.nights_stay
                    : Icons.brightness_4,
              ),
              title: const Text('Change Theme'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Theme'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            RadioListTile<ThemeMode>(
                              title: const Text('Light'),
                              value: ThemeMode.light,
                              groupValue: themeMode,
                              onChanged: (ThemeMode? value) {
                                if (value != null) {
                                  onThemeChanged(value);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            RadioListTile<ThemeMode>(
                              title: const Text('Dark'),
                              value: ThemeMode.dark,
                              groupValue: themeMode,
                              onChanged: (ThemeMode? value) {
                                if (value != null) {
                                  onThemeChanged(value);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            RadioListTile<ThemeMode>(
                              title: const Text('System Default'),
                              value: ThemeMode.system,
                              groupValue: themeMode,
                              onChanged: (ThemeMode? value) {
                                if (value != null) {
                                  onThemeChanged(value);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calculator');
              },
              child: const Text('Calculator'),
            ),
          ],
        ),
      ),
    );
  }
}
