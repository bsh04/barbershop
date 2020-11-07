class ResponseModel<TModel> {
  int code;
  String message;
  TModel data;

  ResponseModel(this.code, this.message, this.data);
}