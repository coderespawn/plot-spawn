/** Holds the application specific objects. This object is passed around 
 *  rather than using singleton to access the editor objects 
 */
class Context {
  Context() { 
    this.renderer = new RendererContext();
  }
  
  RendererContext renderer;
  Editor editor;
}

class RendererContext {
  html.CanvasElement canvasElement;
  html.CanvasRenderingContext2D canvas2D;
}
