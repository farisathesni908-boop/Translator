part of 'translate_bloc.dart';

@immutable
sealed class TranslateState {}

final class TranslateInitial extends TranslateState {}
final class Translateloading extends TranslateState{}
final class Translateloaded extends TranslateState{
   final TranslateModel translate;
  Translateloaded(this.translate);
}
final class   TranslateError extends TranslateState{
   final String message;
  TranslateError(this.message);
}