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
    // Only include non-null contents
    return {'contents': contents?.map((c) => c.toJson()).toList()};
  }
}

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

  factory Contents.fromUserMessage(String content) {
    return Contents(
      parts: [Parts(text: content)],
      role: 'user',
    );
  }

  String? role; // "user" or "model"
  List<Parts>? parts;

  Map<String, dynamic> toJson() {
    return {
      if (role != null) 'role': role,
      'parts': parts?.map((p) => p.toJson()).toList(),
    };
  }

  bool get isUser => role == 'user';
}

class Parts {
  Parts({this.text, this.thoughtSignature});

  Parts.fromJson(dynamic json) {
    text = json['text'];
    thoughtSignature = json['thoughtSignature'];
  }

  String? text;
  String? thoughtSignature;

  Map<String, dynamic> toJson() {
    final map = {'text': text};
    if (thoughtSignature != null) map['thoughtSignature'] = thoughtSignature;
    return map;
  }
}
