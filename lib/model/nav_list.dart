class FNavList {
  String icon;
  String title;
  String path;
  String pathName;
  bool isOpen;
  List<FNavList> children;

  FNavList({this.icon, this.title, this.isOpen, this.children, this.path, this.pathName});

  FNavList.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    isOpen = json['isOpen'];
    path = json['path'];
    pathName = json['pathName'];
    if (json['children'] != null) {
      children = new List<Null>();
      json['children'].forEach((v) {
        children.add(new FNavList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['isOpen'] = this.isOpen;
    data['path'] = this.path;
    data['pathName'] = this.pathName;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}