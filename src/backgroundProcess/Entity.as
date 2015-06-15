package backgroundProcess
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses Di Perna
	 */
	public class Entity extends Sprite 
	{
		//Events
		public static const ENTITY_ADDED_TO_STAGE : String = "entityAddedToStage";
		public static const ENTITY_REMOVED_TO_STAGE : String = "entityRemovedToStage";
		
		//Collision
		public var collidingEntities : Array = []; //List of entities colliding with this entity
		
		public function Entity() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			dispatchEvent(new Event(ENTITY_ADDED_TO_STAGE, true));
		}
		
		//---------------------- collision --------------------------
		
		/**
		 * This function checks if this entity will collide with the other(parameter) entity
		 * Ps: Used in the collision system to check if there is collision between one entity and the other
		 * @param	other
		 * @return
		 */
		public function willCollide(other : Entity) : Boolean {
			var result : Boolean = false;
			if (this.hitTestObject(other)) {
				result = true;
			}
			return result;
		}
		
		/**
		 * This function checks if the other(parameter) entity is already colliding with this entity
		 * Ps: Used in the collision system to check if this entity is already colliding with the other.
		 * @param	other
		 * @return
		 */
		public function checkCollidingWithEntity(other : Entity) : Boolean {
			var result : Boolean = false;
			for (var i : int = collidingEntities.length - 1; i >= 0; i--) {
				if (other == collidingEntities[i]) {
					result = true;
					break;
				}
			}
			return result;
		}
		
		/**
		 * This function is triggered when there is a collision with the other(parameter) entity for the first time.
		 * Ps: This function is called and checked by the collision system.
		 * @param	other
		 */
		public function onCollisionEnter(other : Entity) : void {
			collidingEntities.push(other);
		}
		
		/**
		 * This function is triggered every frame when there is a collision with the other(parameter) entity
		 * Ps: This function is called and checked by the collision system.
		 * @param	other
		 */
		public function onCollision(other : Entity) : void {
			
		}
		
		/**
		 * This function is triggere when there is no more collision between this entity and the other(parameter) entity.
		 * Ps: This function is called and checked by the collision system.
		 * @param	other
		 */
		public function onCollisionExit(other : Entity) : void {
			collidingEntities.splice(collidingEntities.indexOf(other), 1);
		}
		
		//---------------------------------------------------------------
		
		public function update() : void {
			
		}
		
		/**
		 * Call this function to remove the entity from the game.
		 */
		public function removeEntity() : void {
			dispatchEvent(new Event(ENTITY_REMOVED_TO_STAGE, true));
			parent.removeChild(this);
		}
	}

}