import 'dart:async';
import 'dart:isolate';

var c1 = Calc(a: 1000, b: 2000);
var c2 = Calc(a: 1000, b: 2000);
void main() async {
  Isolate.run(() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 500), () {});
      print('thr1_____');
      Schedule1().run();
    }
  });

  Isolate.run(() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1), () {});
      print('thr2_____');
      Schedule2().run();
    }
  });
}

class Schedule1 {
  _t1() {
    var a = c1.a;
    a = a - 50;
    c1.a = a;
    var b = c1.b;
    b = b + 50;
    c1.b = b;
  }

  _t2() {
    var a = c1.a;
    var temp = a * .1;

    a = a - temp;
    c1.a = a;
    var b = c1.b;
    b = b + temp;
    c1.b = b;
  }

  run() {
    _t1();
    _t2();

    print(c1.toString());
  }
}

//----
class Schedule2 {
  _t1() {
    var a = c2.a;
    a = a - 50;
    c2.a = a;
    var b = c2.b;
    b = b + 50;
    c2.b = b;
  }

  _t2() {
    var a = c2.a;
    var temp = a * .1;

    a = a - temp;
    c2.a = a;
    var b = c2.b;
    b = b + temp;
    c2.b = b;
  }

  run() {
    _t2();
    _t1();
    print(c2.toString());
  }
}

class Calc {
  double a;
  double b;
  Calc({required this.a, required this.b});

  @override
  String toString() {
    return '(a: $a, b: $b)';
  }
}
