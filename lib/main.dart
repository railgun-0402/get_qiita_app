import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_qiita_app/pages/top/top_page.dart';

void main() {
  runApp(const ProviderScope(child: TopPage()));
}
