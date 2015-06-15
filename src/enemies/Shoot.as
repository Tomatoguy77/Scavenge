package enemies 
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Sebastiaan Kappert
	 */
	public class Shoot extends MovieClip 
	{
		public var bullet:Bulletdblauw = new Bulletdblauw();
		private var hit:Boolean = false;
		private var dist:Number;
		private var dy:Number;
		private var dx:Number;
		private var randMove2:RandMove2 = new RandMove2();
		private var misFire:Number = Math.random() * 5;
		public var startX:Number;
		public var startY:Number;
		private var shootTimer:Timer = new Timer(5000,0);
		
		public function Shoot() 
		{
			
			bullet.scaleX = 0.1;
			bullet.scaleY = 0.1;
			shot();
			shootTimer.addEventListener(TimerEvent.TIMER, timeListne);
			shootTimer.start();
			
		}
		
		private function timeListne(e:TimerEvent):void 
		{
			addChild(bullet);
		}
		
		public function shot():void 
		{
			
			addChild(bullet);
			
			
		}
		public function bulletDistance():void 
		{
			
			 dx = bullet.x-stage.stageWidth / 2;
			 dy = bullet.y-stage.stageHeight / 2;
			 dist = Math.sqrt(dx * dx + dy * dy);
			 
		}
		
		public function move():void 
		{
			if (dist > 30) 
			{
				if (startX < stage.stageWidth / 2) 
				{
					bullet.y = bullet.y + misFire;
					bullet.x = bullet.x + 10;
				}
				if (startY < stage.stageHeight / 2 ) 
				{
					bullet.y = bullet.y + 10
					bullet.x = bullet.x + misFire;

				}
				if (startX > stage.stageWidth / 2) 
				{
					bullet.y = bullet.y + misFire;
					bullet.x = bullet.x - 10;
				}
				if (startY > stage.stageHeight / 2) 
				{
					bullet.x = bullet.x + misFire;
					bullet.y = bullet.y - 10;
				}
			}
		}
		
		
		private function rotate()
		{
			var r:Number = Math.atan2(stage.stageHeight / 2 - bullet.y, stage.stageWidth / 2 - bullet.x);
			var degrees:Number = r * 180 / Math.PI;
		}
		
		
		
	}

}