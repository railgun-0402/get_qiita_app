import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key, @required this.url, @required this.title});

  /// WebViewとして遷移するURL
  final String? url;
  /// WebViewのタイトル
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // 記事タイトル
          title!,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      body: WebView(
        // WebView表示
        initialUrl: url,
        // JavaScriptを有効化
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
