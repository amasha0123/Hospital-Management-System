class Department {
  final String id;
  final String departmentCode;
  final String name;
  final String description;
  final String head;
  final String location;
  final String status;

  const Department({
    required this.id,
    required this.departmentCode,
    required this.name,
    required this.description,
    required this.head,
    required this.location,
    required this.status,
  });

  factory Department.fromMap(String id, Map<String, dynamic> map) {
    return Department(
      id: id,
      departmentCode: map['departmentCode'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      head: map['head'] ?? '',
      location: map['location'] ?? '',
      status: map['status'] ?? 'Active',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'departmentCode': departmentCode,
      'name': name,
      'description': description,
      'head': head,
      'location': location,
      'status': status,
    };
  }
}
