class Personnel {
  Personnel({
    this.pId,
    this.pPassword,
    this.pName,
    this.pBranch,
    this.pDepartment,
    this.pEducational,
    this.pImg,
    this.dId,
    this.dName,
    this.bId,
    this.bName,
    this.bFaculty,
    this.fId,
    this.fName,
  });

  String pId;
  String pPassword;
  String pName;
  String pBranch;
  String pDepartment;
  String pEducational;
  dynamic pImg;
  String dId;
  String dName;
  String bId;
  String bName;
  String bFaculty;
  String fId;
  String fName;

  Personnel.fromMap(Map<String, dynamic> map) {
    pId = map["p_id"];
    pPassword = map["p_password"];
    pName = map["p_name"];
    pBranch = map["p_branch"];
    pDepartment = map["p_department"];
    pEducational = map["p_educational"];
    pImg = map["p_img"];
    dId = map["d_id"];
    dName = map["d_name"];
    bId = map["b_id"];
    bName = map["b_name"];
    bFaculty = map["b_faculty"];
    fId = map["f_id"];
    fName = map["f_name"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "p_id": pId,
      "p_password": pPassword,
      "p_name": pName,
      "p_branch": pBranch,
      "p_department": pDepartment,
      "p_educational": pEducational,
      "p_img": pImg,
      "d_id": dId,
      "d_name": dName,
      "b_id": bId,
      "b_name": bName,
      "b_faculty": bFaculty,
      "f_id": fId,
      "f_name": fName,
    };
    return map;
  }
}
