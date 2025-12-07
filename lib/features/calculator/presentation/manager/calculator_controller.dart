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
    if (buttonText == 'C') {
      _userQuestion = '';
      _userAnswer = '';
    } else if (buttonText == 'AC') {
      _userQuestion = '';
      _userAnswer = '';
      _history.clear();
      _memory = 0.0;
    } else if (buttonText == 'CE') {
      _userQuestion = '';
    } else if (buttonText == '⌫') {
      if (_userQuestion.isNotEmpty) {
        _userQuestion = _userQuestion.substring(0, _userQuestion.length - 1);
      }
    } else if (buttonText == '±') {
      _toggleSign();
    } else if (buttonText == '=') {
      if (_userQuestion.isNotEmpty) {
        _userAnswer = _calculateUseCase(_userQuestion);
        if (_userAnswer != 'Error' && _userAnswer.isNotEmpty) {
          _addToHistory(_userQuestion, _userAnswer);
        }
      }
    } else if (buttonText == 'MC') {
      _memory = 0.0;
    } else if (buttonText == 'MR') {
      _userQuestion += _formatResult(_memory);
    } else if (buttonText == 'M+') {
      _handleMemoryOperation((val) => _memory += val);
    } else if (buttonText == 'M-') {
      _handleMemoryOperation((val) => _memory -= val);
    } else if (buttonText == 'MS') {
      _handleMemoryOperation((val) => _memory = val);
    } else if (buttonText == '1/x') {
      _userQuestion = '1/($_userQuestion)';
      // Auto calculate for immediate feedback style if preferred, or just build expression
      // For now, let's build expression to be safe
    } else if (buttonText == 'sin' ||
        buttonText == 'cos' ||
        buttonText == 'tan') {
      _handleTrigFunction(buttonText);
    } else if (buttonText == 'ln' || buttonText == 'log') {
      _handleLogFunction(buttonText);
    } else if (buttonText == '√') {
      _userQuestion += '√(';
    } else if (buttonText == 'x²') {
      _userQuestion += '^2';
    } else if (buttonText == 'xʸ') {
      _userQuestion += '^';
    } else if (buttonText == 'π') {
      _userQuestion += 'π';
    } else if (buttonText == 'e') {
      _userQuestion += 'e';
    } else if (buttonText == '!') {
      _handleFactorial();
    } else {
      // If there's an answer and user starts typing a number, start fresh
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

  void _handleMemoryOperation(Function(double) operation) {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = double.tryParse(_userAnswer);
      if (value != null) {
        operation(value);
      }
    } else if (_userQuestion.isNotEmpty) {
      // Try to calculate current expression to store
      final result = _calculateUseCase(_userQuestion);
      if (result != 'Error') {
        final value = double.tryParse(result);
        if (value != null) {
          operation(value);
        }
      }
    }
  }

  void _toggleSign() {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = double.tryParse(_userAnswer);
      if (value != null) {
        _userQuestion = (-value).toString();
        _userAnswer = '';
      }
    } else if (_userQuestion.isNotEmpty) {
      if (_userQuestion.startsWith('-')) {
        _userQuestion = _userQuestion.substring(1);
      } else {
        _userQuestion = '-$_userQuestion';
      }
    }
  }

  void _handleTrigFunction(String func) {
    if (_userAnswer.isNotEmpty && _userAnswer != 'Error') {
      final value = double.tryParse(_userAnswer);
      if (value != null) {
        double result;
        final radians = value * math.pi / 180; // Convert to radians
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
    // Keep only the last 4 records
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
