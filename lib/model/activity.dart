class Activity {
  Activity({
    this.a_id,
    this.a_name,
    this.a_qty,
    this.a_datestart,
    this.a_timestart,
    this.a_dateend,
    this.a_timeend,
    this.a_status,
    this.a_decription,
    this.p_name,
  });

  String a_id;
  String a_name;
  String a_qty;
  DateTime a_datestart;
  String a_timestart;
  DateTime a_dateend;
  String a_timeend;
  String a_status;
  String a_decription;
  String p_name;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        a_id: json["a_id"],
        a_name: json["a_name"],
        a_qty: json["a_qty"],
        a_datestart: DateTime.parse(json["a_datestart"]),
        a_timestart: json["a_timestart"],
        a_dateend: DateTime.parse(json["a_dateend"]),
        a_timeend: json["a_timeend"],
        a_status: json["a_status"],
        a_decription: json["a_decription"],
        p_name: json["p_name"],
      );

  Map<String, dynamic> toJson() => {
        "a_id": a_id,
        "a_name": a_name,
        "a_qty": a_qty,
        "a_datestart":
            "${a_datestart.year.toString().padLeft(4, '0')}-${a_datestart.month.toString().padLeft(2, '0')}-${a_datestart.day.toString().padLeft(2, '0')}",
        "a_timestart": a_timestart,
        "a_dateend":
            "${a_dateend.year.toString().padLeft(4, '0')}-${a_dateend.month.toString().padLeft(2, '0')}-${a_dateend.day.toString().padLeft(2, '0')}",
        "a_timeend": a_timeend,
        "a_status": a_status,
        "a_decription": a_decription,
        "p_name": p_name,
      };
}
