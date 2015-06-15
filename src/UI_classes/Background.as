package UI_classes
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author sjoerd
	 */
	public class Background extends Sprite
	{
		private var i:int;
		public var backGRND:MovieClip;		
		public function Background() 
		{
			
		}
		public function makeBackground(artName:Class, backXpos:Number, backYpos:Number, xScale:Number, yScale:Number, arrayName:Array):void
		{
			backGRND = new artName();
			backGRND.x = backXpos;
			backGRND.y = backYpos;
			backGRND.scaleX = xScale;
			backGRND.scaleY = yScale;
			arrayName.push(backGRND);
			
			addChild(backGRND);
		}
		
		public function move(e:KeyboardEvent):void
		{
			
		}
	}

}
