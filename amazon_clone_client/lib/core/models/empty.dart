class Empty {
  const Empty();

  Map<String, dynamic> toJson() => const <String, dynamic>{};

  factory Empty.fromJson(Map<String, dynamic> map) => const Empty();

  @override
  String toString() => 'Empty';
}
