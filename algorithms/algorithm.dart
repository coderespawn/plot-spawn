interface Algorithm {
  void compute(Context context);
  void render(Context context);
}

class AlgorithmFactory {
  static Algorithm create(String type) {
    if (type == "ConvexHull") {
      return new AlgorithmConvexHull();
    }
    else {
      // TODO: Throw exception
      return null;
    }
  }
}