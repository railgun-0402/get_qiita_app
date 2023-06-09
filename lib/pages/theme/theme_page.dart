import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_qiita_app/pages/theme/theme_strings.dart';

// アプリ全体の外観モードの状態を管理
final themeModeProvider = StateProvider<ThemeMode>((ref)=>ThemeMode.system);

class ThemePage extends ConsumerWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const ThemePageState(),
    );
  }
}

class ThemePageState extends ConsumerWidget {
  const ThemePageState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(screenTitle),
      ),
      body: Column(
        children: [
          changeThemaBtn('light', ref),
          changeThemaBtn('dark', ref),
        ],
      ),
    );
  }

  Widget changeThemaBtn(String kind, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: kind == 'light' ? Colors.black : Colors.white,
            backgroundColor: kind == 'light' ? Colors.grey.shade300 : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            kind == 'light'
                // ライトモード
                ? ref.read(themeModeProvider.notifier).update((state) => ThemeMode.light)
                // ダークモード
                : ref.read(themeModeProvider.notifier).update((state) => ThemeMode.dark);
          },
          child: Text(
            kind == 'light' ? lightModeTitle : darkModeTitle,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

}