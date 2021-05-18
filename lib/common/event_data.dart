class EventData<T> {
  EventData(this.data,
            {this.id,
              this.msg,
              this.others1,
              this.others2,
              this.others3});

  int? id;
  String? msg;
  T data;
  Object? others1;
  Object? others2;
  Object? others3;

}