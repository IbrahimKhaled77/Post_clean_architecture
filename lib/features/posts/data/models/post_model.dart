import 'package:projectclean/features/posts/domain/entities/post.dart';

class PostModels extends Post {
 const PostModels({int? id, required String title, required String body})
      : super(id: id, title: title, body: body);

  factory PostModels.formJson(Map<String, dynamic> json) {
    return PostModels(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
