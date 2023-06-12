import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_qiita_app/pages/article/article_page.dart';
import 'package:get_qiita_app/pages/popular/popular_article_strings.dart';
import 'package:get_qiita_app/view_model/popular/popular_notifier.dart';

class PopularArticlePage extends ConsumerWidget {
  const PopularArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qiitaDataList = ref.watch(articleListViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(screenTitle),
      ),
      body: Container(
        child: qiitaDataList.when(
        data: (qiitaDataList) {
          return ListView.builder(
          itemCount: qiitaDataList.length,
          itemBuilder: (BuildContext context, int index) {
            final qiitaData = qiitaDataList[index];
            return resultItem(context, qiitaData);
          },
        );
      },
      error: (error, stack) => Text('$errorString:$error'),
      loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }

  ///
  /// 記事をそれぞれ表示
  ///
  Widget resultItem(context, qiitaData) {
    /// 記事のタイトル
    String title = qiitaData.title.toString();

    /// 記事のアイコン
    String iconUrl = qiitaData.user.profileImageUrl;
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(iconUrl),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticlePage(
                  url: qiitaData.url,
                  title: title,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
