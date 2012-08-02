class Document {

  Document() {
    entities = new List<Entity>();
    translate = new Vector2(0, 0);
  }

  void addEntity(Entity entity) {
    entities.add(entity);
  }
  
  void removeEntity(Entity entity) {
    int index = entities.indexOf(entity);
    if (index >= 0) {
      entities.removeRange(index, index + 1);
    }
  }
  
  /**
   * Gets the nearest entity to this point
   * @param point   the point from which to search, usually the mouse click position
   * @param maxTolerance  The max no. of pixels the entity could be away from
   */ 
  Entity getNearestEntity(Vector2 point, double maxTolerance) {
    // Find the nearest entity to this point
    // TODO: Optimize this later using an octree of space partitioning
    Entity bestMatch = null;
    double bestDistance = 0.0;
    Iterator<Entity> it = entities.iterator();
    while (it.hasNext()) {
      Entity entity = it.next();
      double distance = (point - entity.position).length();
      if (bestMatch == null || distance < bestDistance) {
        bestMatch = entity;
        bestDistance = distance;
      }
    }
    
    return (bestDistance <= maxTolerance) ? bestMatch : null;
  }
  
  /** Mark the specified entity as selected */
  void selectEntity(Entity entity) {
    // Clear out any previously selected entity
    if (selectedEntity != null) {
      selectedEntity.selected = false;
    }
    
    // Mark the new entity as selected
    selectedEntity = entity;
    selectedEntity.selected = true;
  }
  
  /** Delete an entity from the document */
  void deleteEntity(Entity entity) {
    if (selectedEntity == entity) {
      selectedEntity = null;
    }
    
    int index = entities.indexOf(entity);
    if (index >= 0) {
      entities.removeRange(index, 1);
    }
  }
  
  Entity selectedEntity;
  List<Entity> entities;
  Vector2 translate;
  
}
