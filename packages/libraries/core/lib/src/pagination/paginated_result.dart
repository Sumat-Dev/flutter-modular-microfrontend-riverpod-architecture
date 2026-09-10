/// Generic paginated result. [T] is the domain entity type.
class PaginatedResult<T> {
  const PaginatedResult({
    required this.count,
    required this.items,
    this.next,
    this.previous,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<T> items;

  bool get hasMore => next != null;

  PaginatedResult<R> map<R>(R Function(T item) mapper) => PaginatedResult<R>(
    count: count,
    next: next,
    previous: previous,
    items: items.map(mapper).toList(),
  );
}
