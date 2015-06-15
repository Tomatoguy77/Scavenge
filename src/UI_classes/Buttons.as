package UI_classes 
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Buttons extends Sprite
	{
		public var btn;
		public function Buttons() 
		{
			
		}
		
		public function square(Xpos:Number, Ypos:Number, sizeX:Number, sizeY:Number, color:Number, arrayname:Array):void
		{			
			var square: Sprite = new Sprite();
			square.graphics.beginFill(color);
			square.graphics.drawRect( -(sizeX / 2), -(sizeY / 2), sizeX, sizeY);
			square.x = Xpos;
			square.y = Ypos;
			square.graphics.endFill();
			
			arrayname.push(square);
			
			addChild(square);
		}
		
		public function makeBtn(artName:Class,btnXpos:Number,btnYpos:Number,arrayName:Array):void
		{
			btn = new artName();
			btn.x = btnXpos;
			btn.y = btnYpos;
			
			arrayName.push(btn);
			
			addChild(btn);
		}
	}
}