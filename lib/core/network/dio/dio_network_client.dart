import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_flutter_project/core/network/dio/permission_request.dart';
import 'package:sample_flutter_project/core/network/end_points.dart';
import 'package:sample_flutter_project/core/network/dio/dio_interceptor.dart';

class DioNetworkClient {
  final _dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));

  DioNetworkClient._internal();

  static final _singleton = DioNetworkClient._internal();

  factory DioNetworkClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveTimeout: Endpoints.receiveTimeout, // 15 seconds
      connectTimeout: Endpoints.connectionTimeout,
      sendTimeout: 15000,
    ));
    dio.interceptors.addAll([
      AppInterceptors(
        dio,
      ),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      )
    ]);
    return dio;
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Multipart multiple files:--------------------------------------------------------------------
  Future<dynamic> sendForm(String uri, Map<String, File> files,
      {Map<String, dynamic>? data,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    FormData formData;
    if (data != null) {
      data.addAll(fileMap);
      formData = FormData.fromMap(data);
    } else {
      formData = FormData.fromMap(fileMap);
    }
    try {
      final Response response = await _dio.post(uri,
          data: formData,
          options: options ?? Options(contentType: 'multipart/form-data'),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Multipart single file:--------------------------------------------------------------------
  Future<Response> sendFile(String uri, File file,
      {Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    var len = await file.length();
    try {
      final Response response = await _dio.post(
        uri,
        data: file.openRead(),
        options: options ??
            Options(headers: {
              Headers.contentLengthHeader: len,
            } // set content-length
                ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// Download file:--------------------------------------------------------------------
  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await PermissionRequestForPropSoft.requestPermission(
            Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/RPSApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await PermissionRequestForPropSoft.requestPermission(
            Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      File saveFile = File("${directory.path}/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await _dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {});
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
