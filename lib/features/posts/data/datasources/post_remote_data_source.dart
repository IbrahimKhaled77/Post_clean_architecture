import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/exceptions.dart';
import 'package:projectclean/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

abstract class RemoteDataSources {
  Future<List<PostModels>> getAllPost();

  Future<Unit> addPost(PostModels postModels);

  Future<Unit> deletePost(int postModelsId);

  Future<Unit> updatePost(PostModels postModels);
}

class RemoteDataSourcesImp implements RemoteDataSources {
  final http.Client client;

  RemoteDataSourcesImp({required this.client});

  @override
  Future<List<PostModels>> getAllPost() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts/"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List decodeResponse = json.decode(response.body);
      final List<PostModels> listPostModel = decodeResponse
          .map<PostModels>(
              (itemPostModels) => PostModels.formJson(itemPostModels))
          .toList();

      return listPostModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModels postModels) async {
    final body = {
      'title': postModels.title,
      'body': postModels.body,
    };
    final response = await client.post(
      Uri.parse("$baseUrl/posts/"),
      body: body,
    );
    return addOrUpdateOrDelete(201, response);
  }

  @override
  Future<Unit> deletePost(int postModelsId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/posts/${postModelsId.toString()}'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    return addOrUpdateOrDelete(200, response);
  }

  @override
  Future<Unit> updatePost(PostModels postModels) async {
    final body = {
      'title': postModels.title,
      'body': postModels.body,
    };
    final response = await client.patch(
      Uri.parse("$baseUrl/posts/${postModels.id.toString()}"),
      body: body,
    );
    return addOrUpdateOrDelete(200, response);
  }

  Future<Unit> addOrUpdateOrDelete(int value, http.Response response) {
    if (response.statusCode == value) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
