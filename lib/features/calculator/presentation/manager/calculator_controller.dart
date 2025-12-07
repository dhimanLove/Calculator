import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/entities/calculation_history.dart';
import '../../domain/usecases/calculate_expression_usecase.dart';

class CalculatorController extends ChangeNotifier {
  final CalculateExpressionUseCase _calculateUseCase;

  CalculatorController(this._calculateUseCase);

  String _userQuestion = '';
  String _userAnswer = '';
  bool _isScientificMode = false;
  final List<CalculationHistory> _history = [];
  double _memory = 0.0;

  String get userQuestion => _userQuestion;
  String get userAnswer => _userAnswer;
  bool get isScientificMode => _isScientificMode;
  List<CalculationHistory> get history => _history;
  double get memory => _memory;

  void toggleScientificMode() {
    _isScientificMode = !_isScientificMode;
    notifyListeners();
  }

  void onButtonPressed(String buttonText) {
    if (buttonText == 'AC') {
      _userQuestion = '';
      _userAnswer = '';
    } else if (buttonText == 'C') {
      _handleBackspace();
    } else if (buttonText == '=') {
      if (_userQuestion.isNotEmpty) {
        _userAnswer = _calculateUseCase(_userQuestion);
        if (_userAnswer != 'Error' && _userAnswer.isNotEmpty) {
          _addToHistory(_userQuestion, _userAnswer);
        }
      }
    } else {
      if (_userAnswer.isNotEmpty &&
          !_isOperator(buttonText) &&
          buttonText != '.') {
        _userQuestion = buttonText;
        _userAnswer = '';
      } else {
        _userQuestion += buttonText;
      }
    }
    notifyListeners();
  }

  void _handleBackspace() {
    if (_userAnswer.isNotEmpty) {
      // If there's an answer, clear it and keep the question
      _userAnswer = '';
    } else if (_userQuestion.isNotEmpty) {
      // Delete one character from the question
      _userQuestion = _userQuestion.substring(0, _userQuestion.length - 1);
    }
  }

  void _handleMemoryOperation(Function(double) operation) {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = double.tryParse(_userAnswer);
      if (value != null) {
        operation(value);
      }
    } else if (_userQuestion.isNotEmpty) {
      final result = _calculateUseCase(_userQuestion);
      if (result != 'Error') {
        final value = double.tryParse(result);
        if (value != null) {
          operation(value);
        }
      }
    }
  }

  void _handleTrigFunction(String func) {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = double.tryParse(_userAnswer);
      if (value != null) {
        double result;
        final radians = value * math.pi / 180;
        switch (func) {
          case 'sin':
            result = math.sin(radians);
            break;
          case 'cos':
            result = math.cos(radians);
            break;
          case 'tan':
            result = math.tan(radians);
            break;
          default:
            return;
        }
        _userQuestion = '$func($value°)';
        _userAnswer = _formatResult(result);
        _addToHistory(_userQuestion, _userAnswer);
      }
    } else {
      _userQuestion += '$func(';
    }
  }

  void _handleLogFunction(String func) {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = double.tryParse(_userAnswer);
      if (value != null && value > 0) {
        double result;
        switch (func) {
          case 'ln':
            result = math.log(value);
            break;
          case 'log':
            result = math.log(value) / math.ln10;
            break;
          default:
            return;
        }
        _userQuestion = '$func($value)';
        _userAnswer = _formatResult(result);
        _addToHistory(_userQuestion, _userAnswer);
      }
    } else {
      _userQuestion += '$func(';
    }
  }

  void _handleFactorial() {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = int.tryParse(_userAnswer);
      if (value != null && value >= 0 && value <= 20) {
        int result = 1;
        for (int i = 2; i <= value; i++) {
          result *= i;
        }
        _userQuestion = '$value!';
        _userAnswer = result.toString();
        _addToHistory(_userQuestion, _userAnswer);
      }
    } else {
      _userQuestion += '!';
    }
  }

  String _formatResult(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    String result = value.toStringAsFixed(10);
    result = result.replaceAll(RegExp(r'0*$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result;
  }

  void _addToHistory(String expression, String result) {
    _history.insert(
      0,
      CalculationHistory(
        expression: expression,
        result: result,
        timestamp: DateTime.now(),
      ),
    );
    if (_history.length > 4) {
      _history.removeLast();
    }
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  void loadFromHistory(CalculationHistory item) {
    _userQuestion = item.expression;
    _userAnswer = item.result;
    notifyListeners();
  }

  bool _isOperator(String text) {
    return text == '+' ||
        text == '-' ||
        text == '×' ||
        text == '÷' ||
        text == '%' ||
        text == '^';
  }
}
