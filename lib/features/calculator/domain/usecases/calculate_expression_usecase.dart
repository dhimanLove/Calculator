// ignore_for_file: deprecated_member_use
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class CalculateExpressionUseCase {
  String call(String expression) {
    try {
      if (expression.isEmpty) return '';

      String finalExpression = expression;

      // Replace custom operators with standard ones
      finalExpression = finalExpression.replaceAll('×', '*');
      finalExpression = finalExpression.replaceAll('÷', '/');
      finalExpression = finalExpression.replaceAll('π', math.pi.toString());
      finalExpression = finalExpression.replaceAll('e', math.e.toString());

      // Handle scientific functions
      finalExpression = _processScientificFunctions(finalExpression);

      // Use the math_expressions library
      final parser = Parser();
      final exp = parser.parse(finalExpression);
      final contextModel = ContextModel();
      final eval = exp.evaluate(EvaluationType.REAL, contextModel);

      // Handle special cases
      if (eval.isNaN) return 'Error';
      if (eval.isInfinite) return 'Infinity';

      // Format the result
      if (eval % 1 == 0) {
        return eval.toInt().toString();
      }

      // Limit decimal places to 10 and remove trailing zeros
      String result = eval.toStringAsFixed(10);
      result = result.replaceAll(RegExp(r'0*$'), '');
      result = result.replaceAll(RegExp(r'\.$'), '');

      return result;
    } catch (e) {
      return 'Error';
    }
  }

  String _processScientificFunctions(String expression) {
    // This is a simplified version - for more complex scientific functions,
    // you might want to use a more sophisticated parser
    String result = expression;

    // Handle sqrt
    result = result.replaceAllMapped(
      RegExp(r'√\(([^)]+)\)'),
      (match) => 'sqrt(${match.group(1)})',
    );

    return result;
  }
}
