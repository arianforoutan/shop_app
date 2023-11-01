part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CommentInitialzeEvent extends CommentEvent {
  String productId;
  CommentInitialzeEvent(this.productId);
}
