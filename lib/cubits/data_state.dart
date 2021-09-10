abstract class DataState<T> {
  const DataState();
}

class DataInitial<T> extends DataState<T> {
  const DataInitial();
}

class DataLoaded<T> extends DataState<T> {
  T data;

  DataLoaded([this.data]);
}

class DataLoading<T> extends DataState<T> {
  final T data;

  DataLoading([this.data]);
}

class DataEmpty<T> extends DataState<T> {
  final String message;

  DataEmpty(this.message);
}

class DataFailed<T> extends DataState<T> {
  final String message;
  final int statusCode;

  DataFailed(this.message, {this.statusCode = 0});
}
