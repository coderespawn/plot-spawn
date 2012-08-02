class NameProvider {
  static String getUniqueName(String namePrefix) {
    counter++;
    return "namePrefix$counter";
  }
  
  static int counter = 0;
}
