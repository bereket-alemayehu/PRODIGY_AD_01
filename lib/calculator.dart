import 'package:flutter/material.dart';
import 'package:simple_calculator/calculatorButton.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  List<String> operatorsAndNumbers = [
    '7',
    '8',
    '9',
    '+',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    'X',
    'C',
    '0',
    '=',
    '/'
  ];

  int buttonsPerRow = 4;
/*
void main() {
  String expression = '2+3+4';
  List<String> tokens = expression.split('');
  Stack<num> operandStack = Stack();

  for (String token in tokens) {
    if (num.tryParse(token) != null) {
      operandStack.push(double.parse(token));
    } else {
      num operand2 = operandStack.pop();
      num operand1 = operandStack.pop();
      switch (token) {
        case '+':
          operandStack.push(operand1 + operand2);
          break;  case '-':
          operandStack.push(operand1 - operand2);
          break;  case '*':
          operandStack.push(operand1 * operand2);
          break; case '/':
          operandStack.push(operand1 / operand2);
          break;
        // Add other operators as needed
        default:
          // Handle unsupported operators
          break;
      }
    }
  }

  print(operandStack.single); // Output: 9
} */
  String inputFieldValue = ''; // Display field value
  String inputBuffer = ''; // Buffer to accumulate input digits
  List<double> operandStack = []; // Stack to store operands
  List<String> operatorStack = []; // Stack to store operators
  bool hasDecimal =
      false; // Flag to track if the current number has a decimal point
  bool isNegative = false; // Flag to track if the current number is negative

  void updateInputFieldValue(String value) {
    setState(() {
      if (value == 'C') {
        inputFieldValue = '';
        operandStack.clear();
        operatorStack.clear();
        inputBuffer = ''; // Clear the input buffer
        hasDecimal = false; // Reset the decimal flag
        isNegative = false; // Reset the negative flag
      } else if (value == '=') {
        if (inputBuffer.isNotEmpty) {
          double operand = double.parse(inputBuffer);
          if (isNegative) {
            operand = -operand;
          }
          operandStack.add(operand);
          inputBuffer = ''; // Clear the buffer after adding to stack
        }
        if (operandStack.length > 1 && operatorStack.isNotEmpty) {
          // Evaluate the expression
          double result = operandStack[0];
          for (int i = 1; i < operandStack.length; i++) {
            switch (operatorStack[i - 1]) {
              case '+':
                result += operandStack[i];
                break;
              case '-':
                result -= operandStack[i];
                break;
              case 'X':
                result *= operandStack[i];
                break;
              case '/':
                if (operandStack[i] != 0) {
                  result /= operandStack[i];
                } else {
                  inputFieldValue = 'Error: Division by zero';
                  return;
                }
                break;
              default:
                inputFieldValue = 'Error: Unsupported operator';
                return;
            }
          }
          inputFieldValue = result.toString();
          operandStack.clear();
          operatorStack.clear();
        } else {
          inputFieldValue = inputBuffer;
        }
      } else if (value == '+' || value == '-' || value == 'X' || value == '/') {
        if (inputBuffer.isNotEmpty) {
          double operand = double.parse(inputBuffer);
          if (isNegative) {
            operand = -operand;
          }
          operandStack.add(operand);
          inputBuffer = ''; // Clear the buffer after adding to stack
        }
        if (value == '-' && inputFieldValue.isEmpty) {
          isNegative = true;
        } else {
          if (value == '-' &&
              operatorStack.isNotEmpty &&
              operatorStack.last == '-') {
            // Handle consecutive negative signs
            operandStack.removeLast();
            operatorStack.removeLast();
            operandStack.add(-operandStack.last);
          } else {
            if (operatorStack.isNotEmpty &&
                (operatorStack.last == 'X' || operatorStack.last == '/')) {
              // Evaluate the expression for multiplication and division
              double operand2 = operandStack.removeLast();
              double operand1 = operandStack.removeLast();
              String operator = operatorStack.removeLast();
              double result;
              switch (operator) {
                case 'X':
                  result = operand1 * operand2;
                  break;
                case '/':
                  if (operand2 != 0) {
                    result = operand1 / operand2;
                  } else {
                    inputFieldValue = 'Error: Division by zero';
                    return;
                  }
                  break;
                default:
                  inputFieldValue = 'Error: Unsupported operator';
                  return;
              }
              operandStack.add(result);
            }
            operatorStack.add(value);
          }
        }
        inputFieldValue += value; // Update display with operator
        hasDecimal = false; // Reset the decimal flag
        isNegative = false; // Reset the negative flag
      } else if (value == '.') {
        if (!hasDecimal) {
          inputBuffer += value;
          inputFieldValue += value; // Update display with decimal point
          hasDecimal = true;
        }
      } else {
        inputBuffer += value;
        inputFieldValue += value; // Update display with current input
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 48, 48, 48),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: const Color.fromARGB(255, 251, 231, 181), width: 3),
            ),
            child: TextField(
              controller: TextEditingController(text: inputFieldValue),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 34),
              readOnly: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 30),
                border: OutlineInputBorder(),
                hintText: '0',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          for (var i = 0; i < operatorsAndNumbers.length; i += buttonsPerRow)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: operatorsAndNumbers
                  .skip(i)
                  .take(buttonsPerRow)
                  .map((buttonText) {
                return Calculatorbutton(
                    text: buttonText, onPressed: updateInputFieldValue);
              }).toList(),
            ),
        ],
      ),
    );
  }
}
