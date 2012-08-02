class Vector2 {
  Vector2(this.x, this.y);
  num x;
  num y;
  
  Vector2 operator+(Vector2 other) {
    return new Vector2(x + other.x, y + other.y);
  }
  Vector2 operator-(Vector2 other) {
    return new Vector2(x - other.x, y - other.y);
  }
  Vector2 operator*(Vector2 other) {
    return new Vector2(x * other.x, y * other.y);
  }
  Vector2 operator/(Vector2 other) {
    return new Vector2(x / other.x, y / other.y);
  }
  
  num length() {
    return Math.sqrt(x*x + y*y);
  }
  
  bool liesOnLeft(Vector2 other) {
    // Calculate the corss product. Only the z component is calculated since 
    // both the vectors a & b lie in the XY plane
    num z = this.y * other.x - this.x * other.y;
    
    // If the other vector (b) lies on the left, then the cross product would point upward
    // http://en.wikipedia.org/wiki/File:Right_hand_rule_cross_product.svg
    return z > 0;
  }
}
