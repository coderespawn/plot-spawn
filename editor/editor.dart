class Editor {
  void initialize(Context context) {
    toolbox = new Toolbox(context);
    activeDocument = new Document();
    activeAlgorithm = AlgorithmFactory.create("ConvexHull");
  }
  
  void render(Context context) {
    // Compute the algorithm
    activeAlgorithm.compute(context);
    
    html.CanvasElement canvas = context.renderer.canvasElement;
    html.CanvasRenderingContext2D ctx = context.renderer.canvas2D;

    // Clear the canvas
    canvas.width = canvas.width;
    
    context.renderer.canvas2D.save();
    Vector2 translation = this.activeDocument.translate;
    context.renderer.canvas2D.translate(translation.x, translation.y);
    
    // Draw the grid
    drawGrid(context, "#f0f0f0", 10);
    drawGrid(context, "#d0d0d0", 50);
    
    // Draw the entities
    Iterator<Entity> it = activeDocument.entities.iterator();
    while (it.hasNext()) {
      Entity entity = it.next();
      entity.render(context);
    }
    
    // Let the algorithm draw any overlays
    activeAlgorithm.render(context);
    
    // Restore the state
    context.renderer.canvas2D.restore();
  }

  void drawGrid(Context context, String strokeColor, int cellSize) {

    html.CanvasRenderingContext2D ctx = context.renderer.canvas2D;
    ctx.lineWidth = 1;
    
    int canvasWidth = 1000;
    ctx.strokeStyle = strokeColor;

    ctx.beginPath();
    for (int i = 0; i * cellSize < canvasWidth; i++) {
      num x1 = 0;
      num x2 = canvasWidth;
      num y1 = i * cellSize + 0.5;
      num y2 = i * cellSize + 0.5;
      
      // Horizontal line
      ctx.moveTo(x1, y1);
      ctx.lineTo(x2, y2);
      
      // Vertical line
      ctx.moveTo(y1, x1);
      ctx.lineTo(y2, x2);
    }

    ctx.fill();
    ctx.closePath();
    ctx.stroke();
  }
  
  Toolbox toolbox;
  Document activeDocument;
  Algorithm activeAlgorithm;
}
