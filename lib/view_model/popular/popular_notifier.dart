import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_qiita_app/api/popular/popular_api.dart';

/// Qiitaの人気記事を取得する
final articleListViewModelProvider =
FutureProvider.autoDispose<dynamic>((ref) async {
  final qiitaDataList = await PopularAPIRepository();
  return qiitaDataList;
});