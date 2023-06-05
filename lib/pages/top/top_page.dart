import 'package:flutter/material.dart';
import 'package:get_qiita_app/pages/search/search_page.dart';
import 'package:get_qiita_app/pages/setting_top/setting_top_page.dart';

final _pageWidgets = [
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
  /// タブの高さ
  static const double tabBarHeight = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            // TODO: 人気記事のページも作成後、下記実装を利用する
            // BottomNavigationBarItem(icon: Icon(Icons.fire_hydrant), label: '人気記事'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
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
