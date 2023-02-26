class Company {
  Company(
      {required this.company_id,
      required this.name,
      required this.location,
      required this.about,
      required this.type,
      required this.added_date,
      required this.active});
  final int company_id;
  final String name;
  final String location;
  final String about;
  final String type;
  final DateTime added_date;
  final bool active;

  Company copyWith(
      {int? company_id,
      String? name,
      String? location,
      String? about,
      String? type,
      DateTime? added_date,
      bool? active}) {
    return Company(
      company_id: company_id ?? this.company_id,
      name: name ?? this.name,
      location: location ?? this.location,
      about: about ?? this.about,
      type: type ?? this.type,
      added_date: added_date ?? this.added_date,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': company_id,
      'name': name,
      'location': location,
      'about': about,
      'type': type,
      'added_date': added_date,
      'active': active
    };
  }

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
        company_id: json['company_id'] as int,
        name: json['name'] as String,
        location: json['location'] as String,
        about: json['about'] as String,
        type: json['type'] as String,
        added_date: DateTime.parse(json['added_date']) as DateTime,
        active: json['active'] as bool);
  }
}
