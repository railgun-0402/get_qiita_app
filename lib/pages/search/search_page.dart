import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_qiita_app/pages/article/article_page.dart';
import 'package:http/http.dart' as http;

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Search',
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

  void _searchRepositories() async {
    final String searchQuery = _searchController.text.trim();
    if (searchQuery.isEmpty) {
      return;
    }

    final response = await http.get(
      Uri.parse('https://api.github.com/search/repositories?q=$searchQuery'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _searchResults = data['items'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repo Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Keyword',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchRepositories,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final repo = _searchResults[index];
                return ListTile(
                  title: Text(repo['name']),
                  subtitle: Text(repo['description']),
                  trailing: const Icon(Icons.chevron_right),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(repo['owner']['avatar_url']),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(
                          title: repo['name'],
                          url: repo['owner']['html_url'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
