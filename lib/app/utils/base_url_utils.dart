class BaseUrl {
  String url = "api.teledentpregnancy.com";
  // String url = '192.168.56.190:3000';

  String getUrlDevice() {
    return 'https://$url';
  }

  // String getUrlStorage() {
  //   return 'https://$url';
  // }
  //
  // String getWsDevice() {
  //   return 'ws://$url/ws';
  // }
}
