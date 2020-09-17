import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager _instance = NetworkManager._internal();
  Dio _dio;

  ///下一步就是添加options，保存用户的基本信息，比如token
  ///现在的header里面的信息结构
  /// KEY：Cookie
  /// VALUE：[loginUserName=dasonxie; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/, token_pass=3d2722e6451f77cdf993724197f331b9; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/, loginUserName_wanandroid_com=dasonxie; Domain=wanandroid.com; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/, token_pass_wanandroid_com=3d2722e6451f77cdf993724197f331b9; Domain=wanandroid.com; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/]

  // static final Dio dio = Dio();

  ///通用全局单例，第一次使用时初始化
  NetworkManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
          baseUrl: "https://www.wanandroid.com/", connectTimeout: 15000));
      //拦截器，暂时不用
      // _dio.interceptors.add(new DioLogInterceptor());
      // _dio.interceptors.add(new ResponseInterceptors());
      _dio.options.headers = {
        "Cookie":
            "[loginUserName=dasonxie; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/, token_pass=3d2722e6451f77cdf993724197f331b9; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/, loginUserName_wanandroid_com=dasonxie; Domain=wanandroid.com; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/, token_pass_wanandroid_com=3d2722e6451f77cdf993724197f331b9; Domain=wanandroid.com; Expires=Wed, 14-Oct-2020 09:03:53 GMT; Path=/]"
      };
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
      if (_dio.options.baseUrl != "https://www.wanandroid.com/") {
        _dio.options.baseUrl = "https://www.wanandroid.com/";
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
