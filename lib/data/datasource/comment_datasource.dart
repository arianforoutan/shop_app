import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:shop_app/data/model/comment.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exception.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDatasource extends ICommentDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'product_id= "$productId"',
        'expand': 'user_id',
      };
      var response = await _dio.get('collections/comment/records',
          queryParameters: qparams);

      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapjson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      final response = await _dio.post('collections/comment/records', data: {
        'text': comment,
        'user_id': 'lkg8xc50i07oedn',
        'product_id': productId
      });
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
