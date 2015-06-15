package backgroundProcess {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.display.Shape;
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class RandMove extends MovieClip
	{
		private var moveSpeedMax:Number = 1000;
		private var rotateSpeedMax:Number = 15;
		private var decay:Number = .98;
		private var destinationX:int = 150;
		private var destinationY:int = 150;
 
		private var minX:Number = 0;
		private var minY:Number = 0;
		private var maxX:Number = 1920;
		private var maxY:Number = 1080;
 
		private var enemy:enemy1 = new enemy1;
 
		private var dx:Number = 0;
		private var dy:Number = 0;
 
		private var vx:Number = 0;
		private var vy:Number = 0;
 
		private var finalRotation:Number = 0;
		
		public function RandMove()
		{
			createEnemy();
			
			
		}
		
		private function createEnemy():void 
		{
			enemy.scaleY = 0.1;
			enemy.scaleX = 0.1;		
			addChild(enemy);


		}
 		
		public function updatePosition():void
		{
			vx += (destinationX - enemy.x) / moveSpeedMax;
			vy += (destinationY - enemy.y) / moveSpeedMax;
 
			if (getDistance(dx, dy) < 50)
			{
				getRandomDestination();
			}
 
			vx *= decay;
			vy *= decay;
 
			enemy.x += vx;
			enemy.y += vy;
		}
 
		public function updateCollision():void
		{
			if (((enemy.x - enemy.width / 2) < minX) && (vx < 0))
			{
			  vx = -vx;
			}
			if ((enemy.x + enemy.width / 2) > maxX && (vx > 0))
			{
			  vx = -vx;
			}
 
			if (((enemy.y - enemy.height / 2) < minY) && (vy < 0))
			{
			  vy = -vy
			}
			if (((enemy.y + enemy.height / 2) > maxY) && (vy > 0))
			{
			  vy = -vy;
			}
		}
 

		private function getRandomDestination():void
		{
			destinationX = Math.random() * (maxX - enemy.width) + enemy.width / 2;
			destinationY = Math.random() * (maxY - enemy.height) + enemy.height / 2;
		}
 
		
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
 
		
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
 
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
 
		
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
		public function check():void 
		{
			enemy.x = enemy.x + 1;
		}
		
		public function rotate():void 
		{
			dx = enemy.x - destinationX;
			dy = enemy.y - destinationY;
 
			var rotateTo:Number = getDegrees(getRadians(dx, dy));
 
			if (rotateTo > enemy.rotation + 180) rotateTo -= 360;
			if (rotateTo < enemy.rotation - 180) rotateTo += 360;
 
			finalRotation = (rotateTo - enemy.rotation) / rotateSpeedMax;
 
			enemy.rotation += finalRotation;
		}
		
		
 
	}
 
}
