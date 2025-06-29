class ParentModel {
  String? parentId;
  DateTime? createdAt;
  String? name;
  String? email;
  String? password;
  dynamic address;
  String? phone;
  dynamic age;
  dynamic forStudent;
  dynamic forProduct;

  ParentModel({
    this.parentId,
    this.createdAt,
    this.name,
    this.email,
    this.password,
    this.address,
    this.phone,
    this.age,
    this.forStudent,
    this.forProduct,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) => ParentModel(
    parentId: json['parent_id'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    name: json['name'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    address: json['address'] as dynamic,
    phone: json['phone'] as String?,
    age: json['age'] as dynamic,
    forStudent: json['for_student'] as dynamic,
    forProduct: json['for_product'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'parent_id': parentId,
    'created_at': createdAt?.toIso8601String(),
    'name': name,
    'email': email,
    'password': password,
    'address': address,
    'phone': phone,
    'age': age,
    'for_student': forStudent,
    'for_product': forProduct,
  };
}
