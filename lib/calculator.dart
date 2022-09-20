import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          // TODO Add Button PRess
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Calculator",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Calculator Display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 100),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called
                calcbutton('AC', Colors.deepOrange, Colors.white),
                calcbutton('+/-', Colors.deepOrange, Colors.white),
                calcbutton('%', Colors.deepOrange, Colors.white),
                calcbutton('/', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
              // Copy All Row Code Button here!
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called
                calcbutton('7', Colors.white, Colors.deepPurple),
                calcbutton('8', Colors.white, Colors.deepPurple),
                calcbutton('9', Colors.white, Colors.deepPurple),
                calcbutton('X', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
              // Copy All Row Code Button here!
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called
                calcbutton('6', Colors.white, Colors.deepPurple),
                calcbutton('5', Colors.white, Colors.deepPurple),
                calcbutton('4', Colors.white, Colors.deepPurple),
                calcbutton('/', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
              // Copy All Row Code Button here!
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // here button function will be called
                calcbutton('3', Colors.white, Colors.deepPurple),
                calcbutton('2', Colors.white, Colors.deepPurple),
                calcbutton('1', Colors.white, Colors.deepPurple),
                calcbutton('+', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
              // Last Row has Different Button
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 0 Button
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    //Button Function
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.deepPurple,
                    ),
                  ),
                  color: Colors.white,
                ),
                calcbutton('.', Colors.white, Colors.deepPurple),
                calcbutton('=', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  // Calculator Logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
