import 'dart:convert';


JsonDataLogin dataLoginFromJson(String str) => JsonDataLogin.fromJson(json.decode(str));

String dataLoginToJson(JsonDataLogin data) => json.encode(data.toJson());

class JsonDataLogin {
  JsonDataLogin({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  dynamic data;

  factory JsonDataLogin.fromJson(Map<String, dynamic> json) => JsonDataLogin(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data,
  };
}
