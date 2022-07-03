import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityValidator
{
  Future<bool> checkInternetConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    else{
      return false;
    }
  }
}