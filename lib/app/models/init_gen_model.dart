class InitGen {
  String? id;
  String? model;
  String? version;
  Input? input;
  String? logs;
  String? error;
  String? status;
  String? createdAt;
  Urls? urls;

  InitGen(
      {this.id,
      this.model,
      this.version,
      this.input,
      this.logs,
      this.error,
      this.status,
      this.createdAt,
      this.urls});

  InitGen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    version = json['version'];
    input = json['input'] != null ? new Input.fromJson(json['input']) : null;
    logs = json['logs'];
    error = json['error'];
    status = json['status'];
    createdAt = json['created_at'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model'] = this.model;
    data['version'] = this.version;
    if (this.input != null) {
      data['input'] = this.input!.toJson();
    }
    data['logs'] = this.logs;
    data['error'] = this.error;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.urls != null) {
      data['urls'] = this.urls!.toJson();
    }
    return data;
  }
}

class Input {
  String? clothing;
  String? image;
  String? prompt;

  Input({this.clothing, this.image, this.prompt});

  Input.fromJson(Map<String, dynamic> json) {
    clothing = json['clothing'];
    image = json['image'];
    prompt = json['prompt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clothing'] = this.clothing;
    data['image'] = this.image;
    data['prompt'] = this.prompt;
    return data;
  }
}

class Urls {
  String? cancel;
  String? get;

  Urls({this.cancel, this.get});

  Urls.fromJson(Map<String, dynamic> json) {
    cancel = json['cancel'];
    get = json['get'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancel'] = this.cancel;
    data['get'] = this.get;
    return data;
  }
}
