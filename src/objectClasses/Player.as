package objectClasses 
{
	import flash.display.Sprite;
	import stageClasses.Main;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Player extends Sprite
	{
		public var shipImg:Class;
		public var myTankBody:MovieClip;
		public var turretRotation:Number;
		public var targetPosition:Point;
		public var lives:int = 1;
		private var round:int = 1;
		
		public function Player()
		{
			shipImg = spaceShip;
			targetPosition = new Point();
			myTankBody = new shipImg();
			addChild(myTankBody);
			myTankBody.rotationZ = 90;
			myTankBody.scaleX = 0.5;
			myTankBody.scaleY = 0.5;
		}
		
		public function updates():void
		{
			moveShip();
		}
		
		public function moveShip():void
		{
			rotation += Main.input.x * 5;
			var r:Number = rotation * Math.PI / 180;
			var xMove:Number = Math.cos(r);
			var yMove:Number = Math.sin(r);
			
			this.x += Main.input.y * xMove * 0;
			this.y += Main.input.y * yMove * 0;
		}
		
		public function destroy():void
		{
			
		}
	}

}