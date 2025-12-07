import '../repositories/calculator_repository.dart';

class CalculateExpressionUseCase {
  final CalculatorRepository _repository;

  CalculateExpressionUseCase(this._repository);

  String call(String expression) {
    return _repository.calculate(expression);
  }
}
