// ignore_for_file: deprecated_member_use
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import '../../domain/repositories/calculator_repository.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  @override
  String calculate(String expression) {
    try {
      if (expression.isEmpty) return '';

      String finalExpression = expression;

      finalExpression = finalExpression.replaceAll('×', '*');
      finalExpression = finalExpression.replaceAll('÷', '/');
      finalExpression = finalExpression.replaceAll('π', math.pi.toString());
      finalExpression = finalExpression.replaceAll('e', math.e.toString());

      finalExpression = _processScientificFunctions(finalExpression);

      final parser = Parser();
      final exp = parser.parse(finalExpression);
      final contextModel = ContextModel();
      final eval = exp.evaluate(EvaluationType.REAL, contextModel);

      if (eval.isNaN) return 'Error';
      if (eval.isInfinite) return 'Infinity';
      if (eval % 1 == 0) {
        return eval.toInt().toString();
      }

      String result = eval.toStringAsFixed(10);
      result = result.replaceAll(RegExp(r'0*$'), '');
      result = result.replaceAll(RegExp(r'\.$'), '');

      return result;
    } catch (e) {
      return 'Error';
    }
  }

  String _processScientificFunctions(String expression) {
    String result = expression;
    result = result.replaceAllMapped(
      RegExp(r'√\(([^)]+)\)'),
      (match) => 'sqrt(${match.group(1)})',
    );

    return result;
  }
}
