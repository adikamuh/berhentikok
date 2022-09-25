import 'package:meta/meta.dart';

@sealed
abstract class Resource<T> {
  Resource();

  @override
  String toString() => 'Resource of '
      'status: $status, '
      'data: $inferredData, '
      'error message: $inferredErrorMessage';

  factory Resource.idle() {
    return Idle();
  }

  factory Resource.loading({T? data}) {
    return Loading(data);
  }

  factory Resource.success(T data) {
    return Success(data);
  }

  factory Resource.error(String errorMessage, {T? data}) {
    return Error(errorMessage, data);
  }

  factory Resource.of({
    T? data,
    String? errorMessage,
  }) {
    if (errorMessage != null) {
      return Resource.error(errorMessage, data: data);
    } else if (data != null) {
      return Resource.success(data);
    } else {
      return Resource.loading(data: data);
    }
  }

  Resource<U> transform<U>({
    required final U Function(T data) transformer,
  }) {
    final resource = this;

    if (resource is Success<T>) {
      return Resource.success(transformer.call(resource.data));
    }
    final data = resource.inferredData;

    if (resource is Error<T>) {
      return Resource.error(
        resource.errorMessage,
        data: data == null ? null : transformer.call(data),
      );
    }

    if (resource is Loading<T>) {
      return Resource.loading(
        data: data == null ? null : transformer.call(data),
      );
    }

    return Resource.idle();
  }

  String? get inferredErrorMessage {
    final resource = this;

    if (resource is Error<T>) {
      return resource.errorMessage;
    }

    return null;
  }

  T? get inferredData {
    final resource = this;

    if (resource is Success<T>) {
      return resource.data;
    } else if (resource is Error<T>) {
      return resource.data;
    } else if (resource is Loading<T>) {
      return resource.data;
    }

    return null;
  }

  String get status {
    final resource = this;

    if (resource is Success<T>) {
      return Resource.statusSuccess;
    } else if (resource is Error<T>) {
      return Resource.statuesError;
    } else if (resource is Loading<T>) {
      return Resource.statusLoading;
    }

    return Resource.statusIdle;
  }

  U? compose<U>({
    required final U Function(Success<T>) onSuccess,
    final U Function(Error<T>)? onError,
    final U Function(Loading<T>)? onLoading,
    final U Function()? onIdle,
  }) {
    final resource = this;

    if (resource is Success<T>) {
      return onSuccess(resource);
    } else if (resource is Error<T>) {
      return onError?.call(resource);
    } else if (resource is Loading<T>) {
      return onLoading?.call(resource);
    }

    return onIdle?.call();
  }

  U? onSuccess<U>(U Function(Success<T> success) successCallback) {
    final resource = this;

    return resource is Success<T> ? successCallback(resource) : null;
  }

  U? onError<U>(U Function(Error<T> error) errorCallback) {
    final resource = this;

    return resource is Error<T> ? errorCallback(resource) : null;
  }

  U? onLoading<U>(U Function(Loading<T> loading) loadingCallback) {
    final resource = this;

    return resource is Loading<T> ? loadingCallback(resource) : null;
  }

  static const statusSuccess = "success";
  static const statuesError = "error";
  static const statusLoading = "loading";
  static const statusIdle = "idle";
}

class Loading<T> extends Resource<T> {
  Loading(this.data);

  final T? data;
}

class Idle<T> extends Resource<T> {}

class Success<T> extends Resource<T> {
  Success(this.data);

  final T data;
}

class Error<T> extends Resource<T> {
  Error(this.errorMessage, this.data);

  final String errorMessage;
  final T? data;
}
