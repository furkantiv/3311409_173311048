import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Bildirimler'),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
            ),
          ),
          ListTile(
            title: Text('Tema'),
            trailing: DropdownButton<String>(
              value: 'Açık Tema',
              onChanged: (String? newValue) {},
              items: <String>['Açık Tema', 'Koyu Tema']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text('Dil'),
            trailing: DropdownButton<String>(
              value: 'Türkçe',
              onChanged: (String? newValue) {},
              items: <String>['Türkçe', 'İngilizce']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text('Hakkında'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Hakkında sayfasına yönlendirme yap
            },
          ),
        ],
      ),
    );
  }
}
