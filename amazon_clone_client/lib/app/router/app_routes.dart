enum AppRoutes {
  auth('/auth'),
  home('/home');
  final String path;

  const AppRoutes(this.path);

  @override
  String toString() => 'Route Path: $path, Name: $name';
}
