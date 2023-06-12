import 'package:flutter/material.dart';
import 'package:get_qiita_app/pages/popular/popular_article_page.dart';
import 'package:get_qiita_app/pages/search/search_page.dart';
import 'package:get_qiita_app/pages/settings/setting_top/setting_top_page.dart';
import 'package:get_qiita_app/pages/top/top_strings.dart';

final _pageWidgets = [
  const PopularArticlePage(),
  const SearchPage(),
  const SettingTopPage()
];

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.fire_hydrant), label: popularTab),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: searchTab),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: settingTab),
          ],
          currentIndex: _currentIndex,
          fixedColor: Colors.blueAccent,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
        /// body部分
        body: _pageWidgets.elementAt(_currentIndex),
      ),
    );
  }
  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}
