class UpdateResponse {
  UpdateResponse({
    this.message,
    this.status,});

  UpdateResponse.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
  }
  String? message;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}