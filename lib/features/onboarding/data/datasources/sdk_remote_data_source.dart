import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/sdk_version.dart';

abstract class SdkRemoteDataSource {
  Future<List<SdkVersion>> fetchSdkVersions();
  Future<List<SdkVersion>> fetchAndroidSdkVersions();
}

class SdkRemoteDataSourceImpl implements SdkRemoteDataSource {
  final http.Client client;
  SdkRemoteDataSourceImpl({required this.client});
  @override
  Future<List<SdkVersion>> fetchSdkVersions() async {
    final uri = Uri.parse(
      'https://api.github.com/repos/mumumusuc/termux-flutter/releases',
    );
    final response = await client.get(
      uri,
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      final releases =
          jsonList.map((json) => SdkVersion.fromJson(json)).toList();

      return releases
          .where(
              (release) => _isVersionGreaterOrEqual(release.tagName, '3.19.0'))
          .toList();
    } else {
      throw Exception('Failed to load releases');
    }
  }

  @override
  Future<List<SdkVersion>> fetchAndroidSdkVersions() async {
    final uri = Uri.parse(
      'https://api.github.com/repos/lzhiyong/android-sdk-tools/releases',
    );
    final response = await client.get(
      uri,
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      final releases =
          jsonList.map((json) => SdkVersion.fromJson(json)).toList();

      return releases
          .where(
              (release) => _isVersionGreaterOrEqual(release.tagName, '3.19.0'))
          .toList();
    } else {
      throw Exception('Failed to load releases');
    }
  }
}

bool _isVersionGreaterOrEqual(String version, String minimumVersion) {
  if (version.startsWith('v')) {
    version = version.substring(1);
  }
  if (minimumVersion.startsWith('v')) {
    minimumVersion = minimumVersion.substring(1);
  }

  final List<int> versionNums =
      version.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  final List<int> minimumNums =
      minimumVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

  final int length =
      [versionNums.length, minimumNums.length].reduce((a, b) => a > b ? a : b);
  while (versionNums.length < length) {
    versionNums.add(0);
  }
  while (minimumNums.length < length) {
    minimumNums.add(0);
  }

  for (int i = 0; i < length; i++) {
    if (versionNums[i] > minimumNums[i]) {
      return true;
    } else if (versionNums[i] < minimumNums[i]) {
      return false;
    }
  }

  return true;
}
