class AlgorithmConvexHull implements Algorithm {
  void compute(Context context) {
    
    // Fetch the positions of each entity 
    Document doc = context.editor.activeDocument;
    
    // Need atleast 3 vertices to compute the hull
    if (doc.entities.length < 3) return;
    
    List<Vector2> points = new List<Vector2>();
    for (var i = 0; i < doc.entities.length; i++) {
      Entity entity = doc.entities[i];
      points.add(entity.position); 
    }
    
    // Sort the points based on x axis.  If there is a tie, sort based on y axis
    points.sort(compare(Vector2 a, Vector2 b) {
      if (a.x == b.x) {
        return a.y < b.y ? -1 : 1;
      } 
      return a.x < b.x ? -1 : 1; 
    });
    
    
    // Compute the upper hull
    var upperHull = [];
    var n = points.length;
    upperHull.add(points[0]);
    upperHull.add(points[1]);
    
    for (var i = 2; i < n; i++) {
      upperHull.add(points[i]);
      while (upperHull.length > 2 && 
          makesLeftTurn(
            upperHull[upperHull.length-3], 
            upperHull[upperHull.length-2], 
            upperHull[upperHull.length-1])) 
      {
        // Remove the mid point
        upperHull.removeRange(upperHull.length-2, 1);
      }
    }
    
    // Now calculate the lower hull
    var lowerHull = [];
    lowerHull.add(points[n - 1]);
    lowerHull.add(points[n - 2]);
    for (var i = n - 3; i >= 0; i--) {
      lowerHull.add(points[i]);
      while (lowerHull.length > 2 && 
          makesLeftTurn(
            lowerHull[lowerHull.length-3], 
            lowerHull[lowerHull.length-2], 
            lowerHull[lowerHull.length-1])) 
      {
        // Remove the mid point
        lowerHull.removeRange(lowerHull.length-2, 1);
      }
    }
    
    // Remove the first and last point from the lower hull since they are duplicates
    lowerHull.removeRange(lowerHull.length - 1, 1);
    lowerHull.removeRange(0, 1);
    
    // Append the lower hull to the upper hull
    for (var i = 0; i < lowerHull.length; i++) {
      upperHull.add(lowerHull[i]);
    }
    
    // Cache the result for rendering later on
    this.hull = upperHull;
  }
  
  bool makesLeftTurn(Vector2 v1, Vector2 v2, Vector2 v3) {
    Vector2 a = v2 - v1;
    Vector2 b = v3 - v2;
    return a.liesOnLeft(b);
  }
  
  void render(Context context) {
    if (hull == null || hull.length == 0) return;
    
    html.CanvasRenderingContext2D ctx = context.renderer.canvas2D;
    ctx.lineWidth = 3;
    ctx.strokeStyle = "#00ff00";

    ctx.beginPath();

    ctx.moveTo(hull[0].x, hull[0].y);
    for (var i = 0; i < hull.length; i++) {
      ctx.lineTo(hull[i].x, hull[i].y);
    }
    ctx.lineTo(hull[0].x, hull[0].y);

    //ctx.fill();
    ctx.closePath();
    ctx.stroke();
  }
  
  var hull = null;
}
