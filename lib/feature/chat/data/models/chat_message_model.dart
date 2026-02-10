/// contents : [{"role":"user","parts":[{"text":"hi"}]},{"parts":[{"text":"Hello! How can I help you today?","thoughtSignature":"EpoBCpcBAb4+9vsxc+aIw2GKTmx/+xifRZYh6LB8Xf3zCbKdy/sqOV8rv6B7uVhwFOhfy7OESqPJSZyjoSCtqAt74pC3MMQwP2B8ii9GTFLDF6jDyCAQd08zaUfUrCLFu/o/p49nqewEX7CuxSoFNmRbYYP3N5mR2vl1NC8+inIp16W6pqkIhQXJWYDoSjEKU9hvbBsXF1ja1oDkJg=="}],"role":"model"},{"role":"user","parts":[{"text":"what is first question i asked?"}]}]

class ChatMessageModel {
  ChatMessageModel({this.contents});

  ChatMessageModel.fromJson(dynamic json) {
    if (json['contents'] != null) {
      contents = [];
      json['contents'].forEach((v) {
        contents?.add(Contents.fromJson(v));
      });
    }
  }

  List<Contents>? contents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (contents != null) {
      map['contents'] = contents?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// role : "user"
/// parts : [{"text":"hi"}]

class Contents {
  Contents({this.role, this.parts});

  Contents.fromJson(dynamic json) {
    role = json['role'];
    if (json['parts'] != null) {
      parts = [];
      json['parts'].forEach((v) {
        parts?.add(Parts.fromJson(v));
      });
    }
  }

  String? role;
  List<Parts>? parts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    if (parts != null) {
      map['parts'] = parts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "hi"

class Parts {
  Parts({this.text});

  Parts.fromJson(dynamic json) {
    text = json['text'];
  }

  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    return map;
  }
}
