
/** All editor tools must implement this interface */
interface Tool {
  void onMouseDown(Context context, html.MouseEvent evt);
  void onMouseUp(Context context, html.MouseEvent evt);
  void onMouseMove(Context context, html.MouseEvent evt);
}

/** Tool for panning throught the viewport */
class ToolDrag implements Tool {
  ToolDrag.withContext(Context context) {
    context.renderer.canvasElement.style.cursor = "move"; 
  }
  
  void onMouseDown(Context context, html.MouseEvent evt) {
    previousPoint = new Vector2(evt.x, evt.y);
    dragging = true;
  }
  void onMouseUp(Context context, html.MouseEvent evt) {
    dragging = false;
  }
  void onMouseMove(Context context, html.MouseEvent evt) {
    if (!dragging) return;
    
    Vector2 mousePoint = new Vector2(evt.x, evt.y);
    Vector2 delta = mousePoint - previousPoint;
    previousPoint = mousePoint;
    
    context.editor.activeDocument.translate = context.editor.activeDocument.translate + delta; 
    context.editor.render(context);
    
  }
  
  Vector2 previousPoint;
  bool dragging = false;
}



/** Tool for adding new points to the document */
class ToolAddPoint implements Tool {
  ToolAddPoint.withContext(Context context) {
    context.renderer.canvasElement.style.cursor = "crosshair";
  }
  
  void onMouseDown(Context context, html.MouseEvent evt) {
    // Add a point on mouse down
    Vector2 position = new Vector2(evt.offsetX, evt.offsetY);
    
    // apply inverse transform of the view matrix.
    position = position - context.editor.activeDocument.translate;
    
    // Add the point to the document
    addPoint(context, position);
  }
  
  void addPoint(Context context, Vector2 position) {
    PointEntity point = new PointEntity();
    point.position = position;
    context.editor.activeDocument.addEntity(point);
    
    // Request a repaint of the canvas
    context.editor.render(context);
  }

  void onMouseUp(Context context, html.MouseEvent evt) {
  }
  void onMouseMove(Context context, html.MouseEvent evt) {
  }
  
}




/** Tool for deleting existing points in the document */
class ToolDeletePoint implements Tool {
  ToolDeletePoint.withContext(Context context) {
    context.renderer.canvasElement.style.cursor = "crosshair";
  }
  
  void onMouseDown(Context context, html.MouseEvent evt) {

    Vector2 position = new Vector2(evt.offsetX, evt.offsetY);

    // apply inverse transform of the view matrix.
    position = position - context.editor.activeDocument.translate;
    
    // Request the nearest object from the cursor's point
    Entity selectedEntity = context.editor.activeDocument.getNearestEntity(position, 15.0);
    
    if (selectedEntity != null) {
      // Request the deletion of this entity
      context.editor.activeDocument.deleteEntity(selectedEntity);
      
      // Render the canvas again
      context.editor.render(context);
    }
  }
  
  void onMouseUp(Context context, html.MouseEvent evt) {
  }
  void onMouseMove(Context context, html.MouseEvent evt) {
  }
  
}


/** Tool for dragging existing points around */
class ToolMovePoint implements Tool {
  ToolMovePoint.withContext(Context context) {
    context.renderer.canvasElement.style.cursor = "crosshair";
  }
  
  void onMouseDown(Context context, html.MouseEvent evt) {
    Vector2 position = new Vector2(evt.offsetX, evt.offsetY);

    // apply inverse transform of the view matrix.
    position = position - context.editor.activeDocument.translate;
    
    // Request the nearest object from the cursor's point
    selectedEntity = context.editor.activeDocument.getNearestEntity(position, 15.0);
    
    if (selectedEntity != null) {
      // Request the selection of this object
      context.editor.activeDocument.selectEntity(selectedEntity);
      
      // Render the canvas again
      context.editor.render(context);
      
      dragging = true;
    }
  }
  
  void addPoint(Context context, Vector2 position) {
    PointEntity point = new PointEntity();
    point.position = position;
    context.editor.activeDocument.addEntity(point);
    
    // Request a repaint of the canvas
    context.editor.render(context);
  }

  void onMouseUp(Context context, html.MouseEvent evt) {
    dragging = false;
  }
  void onMouseMove(Context context, html.MouseEvent evt) {
    if (!dragging) return;
    
    Vector2 position = new Vector2(evt.offsetX, evt.offsetY);
    
    // apply inverse transform of the view matrix.
    position = position - context.editor.activeDocument.translate;
    
    selectedEntity.position = position;
    
    // Render the canvas 
    context.editor.render(context);
  }
  
  bool dragging = false;
  Entity selectedEntity = null;
}
