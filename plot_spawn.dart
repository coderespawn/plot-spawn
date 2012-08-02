#library ('coderespawn:plotter');

#import('dart:html', prefix: "html");

#source('editor/editor.dart');
#source('editor/context.dart');
#source('editor/tools.dart');
#source('editor/entity.dart');
#source('editor/toolbox.dart');
#source('editor/document.dart');

#source('algorithms/algorithm.dart');
#source('algorithms/algorithm_convex_hull.dart');

#source('utils/math_utils.dart');
#source('utils/editor_utils.dart');

class CryoPlotter {

  CryoPlotter() {
  }

  void run() {
    
    html.CanvasElement canvas = html.document.query("#canvas");
    html.CanvasRenderingContext2D ctx = canvas.getContext("2d");
    
    // Build the context object
    context = new Context();
    context.renderer.canvasElement = canvas;
    context.renderer.canvas2D = ctx;
    
    context.editor = new Editor();
    context.editor.initialize(context);

    context.editor.render(context);
  }

  Context context;
}

void main() {
  new CryoPlotter().run();
}
