import 'package:dio/dio.dart';
import 'package:wanandroid/model/baseModel.dart';

class NetworkManager {
  static NetworkManager _instance = NetworkManager._internal();
  Dio _dio;

  // static final Dio dio = Dio();

  ///通用全局单例，第一次使用时初始化
  NetworkManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
          baseUrl: "http://www.wanandroid.com/", connectTimeout: 15000));
      //拦截器，暂时不用
      // _dio.interceptors.add(new DioLogInterceptor());
      // _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static NetworkManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  NetworkManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  NetworkManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != "http://www.wanandroid.com/") {
        _dio.options.baseUrl = "http://www.wanandroid.com/";
      }
    }
    return this;
  }

  request(String url,
      {String method = "post", Map<String, dynamic> params}) async {
    // 1.创建单独配置
    final options = Options(method: method);

    // 2.发送网络请求
    try {
      Response response =
          await _dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
