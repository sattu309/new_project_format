class NotificationDetailModel {
  String? success;
  Notifications? notifications;

  NotificationDetailModel({this.success, this.notifications});

  NotificationDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    notifications = json['notifications'] != null
        ? new Notifications.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.notifications != null) {
      data['notifications'] = this.notifications!.toJson();
    }
    return data;
  }
}

class Notifications {
  dynamic id;
  dynamic titletext;
  dynamic bodytext;
  dynamic image;
  dynamic url;
  dynamic storeId;
  dynamic status;
  dynamic createdBy;
  dynamic createdAt;

  Notifications(
      {this.id,
        this.titletext,
        this.bodytext,
        this.image,
        this.url,
        this.storeId,
        this.status,
        this.createdBy,
        this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titletext = json['titletext'];
    bodytext = json['bodytext'];
    image = json['image'];
    url = json['url'];
    storeId = json['store_id'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titletext'] = this.titletext;
    data['bodytext'] = this.bodytext;
    data['image'] = this.image;
    data['url'] = this.url;
    data['store_id'] = this.storeId;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}
