//网络请求配置项
class NetworkConfig {
  static NetworkConfig get instance => _getInstance();
  static NetworkConfig _instance;

  NetworkConfig._internal();
  static NetworkConfig _getInstance() {
    if (_instance == null) {
      _instance = new NetworkConfig._internal();
    }
    return _instance;
  }

  //请求头
  Map<String, dynamic> headers = {};

  Function(int code, String msg) errorCallBack;
}
