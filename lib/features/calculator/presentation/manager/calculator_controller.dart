import 'package:flutter/material.dart';
import '../../domain/entities/calculation_history.dart';
import '../../domain/usecases/calculate_expression_usecase.dart';

class CalculatorController extends ChangeNotifier {
  final CalculateExpressionUseCase _calculateUseCase;

  CalculatorController(this._calculateUseCase);

  String _userQuestion = '';
  String _userAnswer = '';
  bool _isScientificMode = false;
  final List<CalculationHistory> _history = [];

  String get userQuestion => _userQuestion;
  String get userAnswer => _userAnswer;
  bool get isScientificMode => _isScientificMode;
  List<CalculationHistory> get history => _history;

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
