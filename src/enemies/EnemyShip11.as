package enemies
{
	import flash.display.MovieClip;
	 import flash.events.TimerEvent;
	 import flash.geom.Matrix;
	 import flash.utils.Timer;
	 import flash.display.Graphics;
	 
	 
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	
	 
	public class EnemyShip11 extends MovieClip 
	{
		
		// variables for the random spawning
		private var radius:Number = 1000;
		private var angle:Number;
		private var dist:Number;
		public var spawnX:Number;
		public var spawnY:Number;
		
		private var lives:Number = 1;
		
		public var inRange:Boolean;
		public var enemy:Enemy11 = new Enemy11;
		private var randMove:RandMove = new RandMove;
		
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
		
		private var enemyAr:Array = new Array();
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var finalRotation:Number = 0;
		private var myTimer:Timer = new Timer(2000, 8);
		private var shoot:Shoot = new Shoot();
		public var shooting:Boolean = false;
		
		//enemy ships
		public var _enemy0:Enemy2 = new Enemy2;
		public var _enemy1:enemy1 = new enemy1;
		
		
		public function EnemyShip11() 
		{
			createEnemy();
			myTimer.addEventListener(TimerEvent.TIMER, TimeListener);
			myTimer.start();
		}
		
		private function TimeListener(e:TimerEvent):void 
		{
		}
		
		
		
		public function choosSpawn()
		{
			angle = 2 * Math.PI * Math.random();
			spawnX = radius * Math.cos(angle);
			spawnY = radius * Math.sin(angle);
			
		}
		

		public function regulateMovement():void 
		{
			
			
			if (dist <= 600 ) 
			{
				inRange = true;
			}
	
			if (inRange == true) 
			{
			//	updateCollision();
				rotate();
				updatePosition();
				rotateEnemy();
				
			
			} 
			
			
			if (inRange == false) 
			{
				if (enemy.x < stage.stageWidth) 
				{
					enemy.x = enemy.x + 15;
				}
				if (enemy.x > stage.stageWidth) 
				{
					enemy.x = enemy.x - 15;
				}
				if (enemy.y < stage.stageHeight) 
				{
					enemy.y = enemy.y + 15;
				}
				if (enemy.y >stage.stageHeight) 
				{
					enemy.y = enemy.y - 15;
				}
			
			}
			
		
			
		}
		
		
		public function rotateEnemy():void
			  {
				//var dx:Number = stage.stageWidth / 2;
		//		var dy:Number = stage.stageHeight / 2;
				var r:Number = Math.atan2(stage.stageHeight / 2 - enemy.y, stage.stageWidth / 2 - enemy.x);
				var degrees:Number = r * 180 / Math.PI;
				degrees = degrees + 95;
				enemy.rotation = degrees;
			  }
			
		private function createEnemy():void 
		{
			choosSpawn();
			enemy.scaleX = 0.2;
			enemy.scaleY = 0.2;
			enemy.x = spawnX;
			enemy.y = spawnY;
			inRange = false;
			addChild(enemy);
		}
		
		public function updatePosition():void
		{
			vx += (destinationX - enemy.x) / moveSpeedMax;
			vy += (destinationY - enemy.y) / moveSpeedMax;
 
			if (getDistance(dx, dy) < 500)
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
		
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/360));
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
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
 
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		public function checkDistance():void 
		{
			
			 dx = enemy.x-stage.stageWidth / 2;
			 dy = enemy.y-stage.stageHeight / 2;
			 dist = Math.sqrt(dx*dx + dy*dy);
		}
		

	}
}