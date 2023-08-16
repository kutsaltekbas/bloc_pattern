import 'package:bloc_pattern/bloc/cat_model.dart';

abstract class CatsState{
  CatsState();
}

class CatsInitial extends CatsState{
  CatsInitial();
}

class CatsLoading extends CatsState{
  CatsLoading();
}

class CatsCompleted extends CatsState{
  final List<CatModel> response;

  CatsCompleted(this.response);

}
class CatsError extends CatsState{
  final String message;

  CatsError(this.message);

}