abstract class Readable<T> {
  Future<List<T>> readAll();
}

abstract class Writable<T> {
  Future<void> write(T item);
}

abstract class Deletable {
  Future<void> delete(String id);
}
