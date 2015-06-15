package enemies
{
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import flash.display.Graphics;
	import flash.display.Stage;


	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class EnemyMove extends 
	{
		private var moveSpeedMax:Number = 1000; 
		private var rotateSpeedMax:Number = 15;
		private var decay:Number = .98;
		private var destinationX:int = 300;
		private var destinationY:int = 300;
 
		private var minX:Number = 0;
		private var minY:Number = 0;
		private var maxX:Number = 1920;
		private var maxY:Number = 1080;
		private var dx:Number = 0;
		private var dy:Number = 0;
		private var vx:Number = 0;
		private var vy:Number = 0;
		

		public function EnemyMove() 
		{
			
		}
		
		}
		
		public function updatePosition(pos):void
		{
			vx += (destinationX - pos.x) / moveSpeedMax;
			vy += (destinationY - pos.y) / moveSpeedMax;
 
			if (getDistance(dx, dy) < 500)
			{
				getRandomDestination();
			}
 
			vx *= decay;
			vy *= decay;
				
			pos.x += vx;
			pos.y += vy;
		}
		
		public function updateCollision(pos):void
		{
			if (((pos.x - pos.width / 2) < minX) && (vx < 0))
			{
			  vx = -vx;
			}
			if ((pos.x + pos.width / 2) > maxX && (vx > 0))
			{
			  vx = -vx;
			}
		
	}
		private function getRandomDestination():void
		{
			destinationX = Math.random() * (maxX - 50) + 50 / 2;
			destinationY = Math.random() * (maxY - 50) + 50 / 2;
		}
		
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/360));
		}
		
		public function check(pos):void 
		{
			pos.x = pos.x + 1;
		}
		
		public function rotate(pos):void 
		{
			dx = pos.x - destinationX;
			dy = pos.y - destinationY;
 
			var rotateTo:Number = getDegrees(getRadians(dx, dy));
 
			if (rotateTo > pos.rotation + 180) rotateTo -= 360;
			if (rotateTo < pos.rotation - 180) rotateTo += 360;
 
			finalRotation = (rotateTo - pos.rotation) / rotateSpeedMax;
 
			pos.rotation += finalRotation;
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
		
		public function checkDistance(pos):void 
		{
			
			 dx = pos.x-stage.stageWidth / 2;
			 dy = pos.y-stage.stageHeight / 2;
			 dist = Math.sqrt(dx*dx + dy*dy);
		}
		

	}
}
		
	}

}