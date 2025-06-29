class StudentModel {
	String? studentId;
	DateTime? createdAt;
	String? studentCode;
	String? name;
	String? age;
	dynamic budget;
	String? email;

	StudentModel({
		this.studentId, 
		this.createdAt, 
		this.studentCode, 
		this.name, 
		this.age, 
		this.budget, 
		this.email, 
	});

	factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
				studentId: json['student_id'] as String?,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				studentCode: json['student_code'] as String?,
				name: json['name'] as String?,
				age: json['age'] as String?,
				budget: json['budget'] as dynamic,
				email: json['email'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'student_id': studentId,
				'created_at': createdAt?.toIso8601String(),
				'student_code': studentCode,
				'name': name,
				'age': age,
				'budget': budget,
				'email': email,
			};
}
