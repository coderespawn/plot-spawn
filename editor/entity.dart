interface Entity {
  void render(Context context);
  Vector2 position;
  String id;
  bool selected;
}


class PointEntity implements Entity {
  PointEntity() {
    id = NameProvider.getUniqueName("Point_");
    radius = 5;
  }
  
  void render(Context context) {
    context.renderer.canvas2D.fillStyle= selected ? "#0000FF" : "#FF0000";
    context.renderer.canvas2D.beginPath();
    context.renderer.canvas2D.arc(position.x, position.y, radius, 0, Math.PI * 2, false);
    context.renderer.canvas2D.closePath();
    context.renderer.canvas2D.fill();
  }
  
  String id;
  Vector2 position;
  bool selected = false;
  num radius;
}
