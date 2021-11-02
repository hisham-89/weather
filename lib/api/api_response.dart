class ApiResponse<T> {
  Status status;

  late T data;

  String message = "";

  ApiResponse.loading():status = Status.LOADING;

  ApiResponse.completed (): status = Status.COMPLETED;

  ApiResponse.error() : status = Status.ERROR;

}

enum Status { LOADING, COMPLETED, ERROR }
