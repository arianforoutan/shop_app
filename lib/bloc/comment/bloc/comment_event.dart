part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CommentInitialzeEvent extends CommentEvent {
  final String productId;
  CommentInitialzeEvent(this.productId);
}

class CommentpostEvent extends CommentEvent {
  final String productId;
  final String comment;
  CommentpostEvent(this.productId, this.comment);
}
