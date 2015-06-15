package
{
	import backgroundProcess.RandMove;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class Spawn extends Sprite 
	{
		
		private var rectangle:Shape = new Shape;
		private var enemy:Shape = new Shape;
		//radius around the player - sebastiaan 
		
		private var radius:Number = 1920;
		
		private var angle:Number = 2 * Math.PI * Math.random();

		public var spawnX:Number = radius * Math.cos(angle);
		public var spawnY:Number = radius * Math.sin(angle);
		// player xpos and ypos have to be moved to another class, probalbly the player class
	
		public var xPosPlayer:Number;
		public var yPosPlayer:Number;
		
		//calling other classes
		private var randMove:RandMove = new RandMove();
		
		
		
		
		

		public function Spawn() 
		{
				//placeholder art - Sebastiaan (TODO replace with .swc image)
			rectangle.graphics.beginFill(0xFF0000); // choosing the colour for the fill, here it is re
			rectangle.graphics.drawRect(0, 0, 100,100); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle); //  adds the rectangle to the stage
			
				//placeholder art enemy - sebastiaan
			enemy.graphics.beginFill(0x00FF00);
			enemy.graphics.drawRect(0, 0, 50, 50);
			enemy.graphics.endFill();
			addChild(enemy);
			rectangle.x = stage.stageWidth / 2;
			rectangle.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, update);
			addChild(randMove);
			
			
			//eventlisteners
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			
			

			
		}
		
		private function update(e:Event):void 
		{
			yPosPlayer = rectangle.y;
			xPosPlayer = rectangle.x;
			
			//TODO actually make this work in the RandMove class without setting everything on fire
			randMove.updatePosition();
			//randMove.updateRotation();
			randMove.rotate();
			randMove.updateCollision();
			//randMove.check();
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//test line to draw to a random location outside of the screen in 360 degrees around the player.
			var g:Graphics = graphics;
			g.moveTo(rectangle.	x + rectangle.width / 2, rectangle.y + rectangle.height / 2);
			g.lineStyle(1,0,100);
			g.lineTo(spawnX + 25, spawnY + 25); 
			
			

		}
		
		
	}
	
}