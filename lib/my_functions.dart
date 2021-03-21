import 'dart:math';

class Functions {
  double randomDouble(int min, int max) {
    Random rnd;
    rnd = new Random();
    return min + rnd.nextInt(max - min).toDouble();
  }
}
