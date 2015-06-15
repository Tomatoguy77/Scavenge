package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	
	public class Spawn extends Sprite
	{
		private var enemies:Array = new Array;
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
		private var randMove2:RandMove2 = new RandMove2();
		private var shoot:Shoot = new Shoot();
		private var myTimer:Timer = new Timer(2000, 0);
		private var enemyShip1:EnemyShip1 = new EnemyShip1();
		private var isShooting:Boolean = false;
		
		public var sEnemyX:Number;
		public var sEnemyY:Number;
		
		private var enemy3:Enemy3 = new Enemy3();
		private var enemy4:Enemy4 = new Enemy4();
		private var shoot2:Shoot2 = new Shoot2();
		private var shoot3:Shoot3 = new Shoot3();
		
		public function Spawn()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function TimeListen(e:TimerEvent):void
		{
			isShooting = true;
			shoot2.bullet.x = enemy3.enemy.x;
			shoot2.bullet.y = enemy3.enemy.y;
			
			shoot3.bullet.x = enemy4.enemy.x;
			shoot3.bullet.y = enemy4.enemy.y;
			
			shoot.bullet.x = randMove2.enemy.x;
			shoot.bullet.y = randMove2.enemy.y;
			sEnemyX = randMove2.enemy.x;
			sEnemyY = randMove2.enemy.y;
			shoot2.startX = enemy3.enemy.x;
			shoot2.startY = enemy3.enemy.x;
			
			shoot3.startX = enemy4.enemy.x;
			shoot3.startY = enemy4.enemy.y;
			
			shoot.startX = randMove2.enemy.x;
			shoot.startY = randMove2.enemy.y;
			
			rotateBullet();
			rotateBullet2();
			rotateBullet3();
			addChild(shoot);
			addChild(shoot2);
			addChild(shoot3);
		}
		
		private function update(e:Event):void
		{
			
			yPosPlayer = rectangle.y;
			xPosPlayer = rectangle.x;
			//randMove.regulateMovement();
			randMove2.regulateMovement();
			enemy3.regulateMovement();
			enemy4.regulateMovement();
			enemyShip1.regulateMovement();
			randMove2.checkDistance();
			enemy3.checkDistance();
			enemy4.checkDistance();
			enemyShip1.checkDistance();
			shoot.bulletDistance();
			shoot2.bulletDistance();
			shoot3.bulletDistance();
			shoot2.move();
			shoot.move();
			shoot3.move();
			//enemyShip1.shooting = false;
			CheckShooting();
		
		}
		
		private function CheckShooting():void
		{
			if (enemyShip1.shooting == true)
			{
				
				addChild(shoot);
				
			}
		}
		
		private function init(e:Event = null):void
		{
			
			addEventListener(Event.ENTER_FRAME, update);
			//	addChild(randMove);
			addChild(randMove2);
			addChild(enemyShip1);
			addChild(enemy3);
			addChild(enemy4);
			myTimer.addEventListener(TimerEvent.TIMER, TimeListen);
			//eventlisteners
			myTimer.start();
			//enemyShip1.createEnemy(enemies);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//addChild(shoot);															
		}
		
		public function rotateBullet():void
		{
			//var dx:Number = stage.stageWidth / 2;
			//		var dy:Number = stage.stageHeight / 2;
			var r:Number = Math.atan2(stage.stageHeight / 2 - shoot.bullet.y, stage.stageWidth / 2 - shoot.bullet.x);
			var degrees:Number = r * 180 / Math.PI;
			degrees = degrees + 95;
			shoot.bullet.rotation = degrees;
		}
		
		public function rotateBullet2():void
		{
			//var dx:Number = stage.stageWidth / 2;
			//		var dy:Number = stage.stageHeight / 2;
			var r:Number = Math.atan2(stage.stageHeight / 2 - shoot2.bullet.y, stage.stageWidth / 2 - shoot2.bullet.x);
			var degrees:Number = r * 180 / Math.PI;
			degrees = degrees + 95;
			shoot2.bullet.rotation = degrees;
		}
		
		public function rotateBullet3():void
		{
			//var dx:Number = stage.stageWidth / 2;
			//		var dy:Number = stage.stageHeight / 2;
			var r:Number = Math.atan2(stage.stageHeight / 2 - shoot3.bullet.y, stage.stageWidth / 2 - shoot3.bullet.x);
			var degrees:Number = r * 180 / Math.PI;
			degrees = degrees + 95;
			shoot3.bullet.rotation = degrees;
		}
	
	}

}