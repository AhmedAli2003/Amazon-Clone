enum AppRoutes {
  auth('/auth'),
  home('/home'),
  splash('/splash'),;

  final String path;

  const AppRoutes(this.path);

  @override
  String toString() => 'Route Path: $path, Name: $name';
}
