class NotificationListModel {
  String? success;
  List<Notifications>? notifications;
  int? unreadnotifications;

  NotificationListModel(
      {this.success, this.notifications, this.unreadnotifications});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    unreadnotifications = json['unreadnotifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    data['unreadnotifications'] = this.unreadnotifications;
    return data;
  }
}

class Notifications {
  String? name;
  String? bodytext;
  String? titletext;
  String? image;
  String? createdAt;
  int? id;
  int? status;

  Notifications(
      {this.name,
        this.bodytext,
        this.titletext,
        this.image,
        this.createdAt,
        this.id,
        this.status});

  Notifications.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bodytext = json['bodytext'];
    titletext = json['titletext'];
    image = json['image'];
    createdAt = json['created_at'];
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bodytext'] = this.bodytext;
    data['titletext'] = this.titletext;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
