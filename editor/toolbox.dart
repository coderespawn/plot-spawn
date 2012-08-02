class Toolbox {
  Toolbox(Context context) {
    this.context = context;
    
    context.renderer.canvasElement.on.mouseUp.add(this.onMouseUp);
    context.renderer.canvasElement.on.mouseDown.add(this.onMouseDown);
    context.renderer.canvasElement.on.mouseMove.add(this.onMouseMoved);
    
    html.AnchorElement btnToolPan = html.query("#btnToolPan");
    html.AnchorElement btnToolAddPoint = html.query("#btnToolAddPoint");
    html.AnchorElement btnToolMovePoint = html.query("#btnToolMovePoint");
    html.AnchorElement btnToolRemovePoint = html.query("#btnToolRemovePoint");
    
    assignButtonTool(btnToolPan, "Drag");
    assignButtonTool(btnToolAddPoint, "AddPoint");
    assignButtonTool(btnToolMovePoint, "MovePoint");
    assignButtonTool(btnToolRemovePoint, "DeletePoint");
    
    setActiveTool("AddPoint");
  }
  
  void assignButtonTool(html.AnchorElement button, String type) {
    button.on.click.add((Event) {
      setActiveTool(type);
    });
  }
  
  void onMouseMoved(html.MouseEvent evt) {
    activeTool.onMouseMove(context, evt);
  }
  
  void onMouseDown(html.MouseEvent evt) {
    activeTool.onMouseDown(context, evt);
  }
  
  void onMouseUp(html.MouseEvent evt) {
    activeTool.onMouseUp(context, evt);
  }
  
  void setActiveTool(String type) {
    Tool tool = ToolFactory.create(context, type);
    this.activeTool = tool;
  }
  
  Tool activeTool;
  Context context;
}


class ToolFactory {
  static Tool create(Context context, String type) {
    if (type == "Drag") {
      return new ToolDrag.withContext(context);
    } else if (type == "AddPoint") {
      return new ToolAddPoint.withContext(context);
    } else if (type == "MovePoint") {
      return new ToolMovePoint.withContext(context);
    } else if (type == "DeletePoint") {
      return new ToolDeletePoint.withContext(context);
    } else {
      // TODO: Throw exception
      html.window.alert("err");
      return null;
    }
  }
}