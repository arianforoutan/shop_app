import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/model/comment.dart';
import 'package:shop_app/data/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository repository;
  CommentBloc(this.repository) : super(CommentLoading()) {
    on<CommentInitialzeEvent>((event, emit) async {
      final response = await repository.getComments(event.productId);

      emit(CommentResponse(response));
    });

    on<CommentpostEvent>((event, emit) async {
      emit(CommentpostLoading(true));

      await repository.postComment(event.productId, event.comment);

      final response = await repository.getComments(event.productId);
      emit(CommentResponse(response));
    });
  }
}
