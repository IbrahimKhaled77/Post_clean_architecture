import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/exceptions.dart';
import 'package:projectclean/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keys = 'data_local';

abstract class LocalDataSources {
  Future<List<PostModels>> getLocalPost();

  Future<Unit> saveLocalPost(List<PostModels> post);
}

class LocalDataSourcesImp implements LocalDataSources {
  final SharedPreferences sharedPreferences;

  LocalDataSourcesImp({required this.sharedPreferences});

  @override
  Future<Unit> saveLocalPost(List<PostModels> post) async {
    List p = post.map<Map<String, dynamic>>((e) => e.toMap()).toList();
    String jsonEncode = json.encode(p);
    sharedPreferences.setString(keys, jsonEncode);
    return Future.value(unit);
  }

  @override
  Future<List<PostModels>> getLocalPost() {
    final jsonEncode = sharedPreferences.getString(keys);
    if (jsonEncode != null) {
      List listJsonEncode = json.decode(jsonEncode);
      List<PostModels> listPostModels = listJsonEncode
          .map<PostModels>(
              (itemPostModels) => PostModels.formJson(itemPostModels))
          .toList();
      return Future.value(listPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
