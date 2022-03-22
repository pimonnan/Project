class Students {
  Students({
    this.sId,
    this.sPassword,
    this.sName,
    this.sBranch,
    this.sCard,
    this.sGenaration,
    this.sGroup,
    this.sImg,
  });

  String sId;
  String sPassword;
  String sName;
  String sBranch;
  String sCard;
  String sGenaration;
  String sGroup;
  dynamic sImg;

  Students.fromMap(Map<String, dynamic> map) {
    sId = map["s_id"];
    sPassword = map["s_password"];
    sName = map["s_name"];
    sBranch = map["s_branch"];
    sCard = map["s_card"];
    sGenaration = map["s_genaration"];
    sGroup = map["s_group"];
    sImg = map["s_img"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "s_id": sId,
      "s_password": sPassword,
      "s_name": sName,
      "s_branch": sBranch,
      "s_card": sCard,
      "s_genaration": sGenaration,
      "s_group": sGroup,
      "s_img": sImg,
    };
    return map;
  }
}
