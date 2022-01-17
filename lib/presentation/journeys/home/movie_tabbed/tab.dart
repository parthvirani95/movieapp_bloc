class Tab {
  final int index;
  final String title;

  const Tab({
    required this.index,
    required this.title,
  })  : assert(index >= 0, 'index cannot be nagative'),
        assert(title != null, 'title cannot be null');
}
