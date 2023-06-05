import 'package:flutter/material.dart';
import 'package:get_qiita_app/api/search_article.dart';
import 'package:get_qiita_app/pages/article/article_page.dart';
import 'package:get_qiita_app/pages/search/search_strings.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: hintText,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final lists = await SearchArticles(_searchController.text);
                    setState(() {
                      _searchResults = lists;
                    });
                  },
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: SearchArticles(_searchController.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return const Text(errorString);
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final repo = _searchResults[index];
                      return ListTile(
                        title: Text(repo['title']),
                        subtitle: Text(repo['user']['id']),
                        trailing: const Icon(Icons.chevron_right),

                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticlePage(
                                    title: repo['title'],
                                    url: repo['url'],
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            }
          },
          ),
        ],
      ),
    );
  }
}
