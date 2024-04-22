class Gen {
  String? id;
  String? uploadedImage;
  String? finalImage;
  String? selfId;
  String? clothingType;
  String? prompt;
  String? createdAt;
  Output? output;
  String? status;
  String? getUrl;
  String? cancelUrl;
  String? logs;
  String? error;
  String? userId;

  Gen(
      {this.id,
      this.uploadedImage,
      this.finalImage,
      this.selfId,
      this.clothingType,
      this.prompt,
      this.createdAt,
      this.output,
      this.status,
      this.getUrl,
      this.cancelUrl,
      this.logs,
      this.error,
      this.userId});

  Gen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadedImage = json['uploaded_image'];
    finalImage = json['final_image'];
    selfId = json['self_id'];
    clothingType = json['clothing_type'];
    prompt = json['prompt'];
    createdAt = json['created_at'];
    output =
        json['output'] != null ? new Output.fromJson(json['output']) : null;
    status = json['status'];
    getUrl = json['get_url'];
    cancelUrl = json['cancel_url'];
    logs = json['logs'];
    error = json['error'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uploaded_image'] = this.uploadedImage;
    data['final_image'] = this.finalImage;
    data['self_id'] = this.selfId;
    data['clothing_type'] = this.clothingType;
    data['prompt'] = this.prompt;
    data['created_at'] = this.createdAt;
    if (this.output != null) {
      data['output'] = this.output!.toJson();
    }
    data['status'] = this.status;
    data['get_url'] = this.getUrl;
    data['cancel_url'] = this.cancelUrl;
    data['logs'] = this.logs;
    data['error'] = this.error;
    data['user_id'] = this.userId;
    return data;
  }
}

class Output {
  String? id;
  String? model;
  String? version;
  Input? input;
  String? logs;
  String? error;
  String? status;
  String? createdAt;
  Urls? urls;

  Output(
      {this.id,
      this.model,
      this.version,
      this.input,
      this.logs,
      this.error,
      this.status,
      this.createdAt,
      this.urls});

  Output.fromJson(Map<String, dynamic> json) {
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
