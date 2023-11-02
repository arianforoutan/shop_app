part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentLoading extends CommentState {}

class CommentResponse extends CommentState {
  final Either<String, List<Comment>> response;
  CommentResponse(this.response);
}

class CommentpostLoading extends CommentState {
  final bool isLoading;

  CommentpostLoading(this.isLoading);
}

class CommentpostRresponse extends CommentState {
  final Either<String, String> response;

  CommentpostRresponse(this.response);
}
