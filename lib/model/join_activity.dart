class JoinActivity {
  String sId;
  String sName;
  String joinStatus;
  String datetime;

  JoinActivity({this.sId, this.sName, this.joinStatus, this.datetime});

  JoinActivity.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    sName = json['s_name'];
    joinStatus = json['join_status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['s_name'] = this.sName;
    data['join_status'] = this.joinStatus;
    data['datetime'] = this.datetime;
    return data;
  }
}
