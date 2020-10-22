import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class OfflineMultiPageLauncher {
  List<Map<String, dynamic>> initialized_files = [];
  FileManager() {}

  Future<String> loadPage(String url) async {
    return await _getFileByUrl(url);
  }

  Future<List<String>> _getHtmlFiles() async {
    var myAssets = await rootBundle.loadString('AssetManifest.json');

    Map<String, dynamic> map = json.decode(myAssets);
    return map.keys
        .toList()
        .where((element) =>
            element.contains('.html') && element.contains('assets/'))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var htmlRawFiles = await _getHtmlFiles();
    print('Raw files $htmlRawFiles');
    for (var files in htmlRawFiles) {
      initialized_files.add({'file': files, 'url': await getUrl(files)});
    }
    print('a');
    return initialized_files;
  }

  Future<String> _getFileByUrl(String url) async {
    List<Map<String, dynamic>> data = await getData();

    return data
        .singleWhere((element) => element.containsValue(url))
        .values
        .toList()
        .first;
  }

  Future<String> getUrl(String fileName) async {
    var myAssets = await rootBundle.loadString(fileName);
    String rawUrl = myAssets.split('\n').firstWhere(
        (element) => element.contains('!-- saved from url='),
        orElse: () => '');
    return parseUrl(rawUrl);
  }

  String parseUrl(String url) {
    return RegExp('https?://[a-zA-z0-9]+\.[a-zA-z]+/?\\S*').stringMatch(url);
  }
}
