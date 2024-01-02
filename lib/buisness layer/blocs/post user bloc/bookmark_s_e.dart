import 'package:equatable/equatable.dart';

enum BookMarkStatus {initial, mark, unMark, failure}

class BookMarkEvent extends Equatable{

  final String uid;
  final String pid;

  BookMarkEvent({required this.pid, required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [pid, uid];
}

class BookMarkState extends Equatable{

  final List<dynamic> myBookmarks;
  final  BookMarkStatus bookMarkStatus;

  BookMarkState({required this.bookMarkStatus, this.myBookmarks = const []});

  BookMarkState.initial() : this(bookMarkStatus: BookMarkStatus.initial);

  BookMarkState.mark(List<dynamic> myBookmarks) : this(myBookmarks: myBookmarks, bookMarkStatus: BookMarkStatus.mark);

  BookMarkState.unMark(List<dynamic> myBookmarks) : this(myBookmarks: myBookmarks, bookMarkStatus: BookMarkStatus.unMark);

  BookMarkState.failure() : this(bookMarkStatus: BookMarkStatus.failure);

  @override
  // TODO: implement props
  List<Object?> get props => [bookMarkStatus, myBookmarks];

}
