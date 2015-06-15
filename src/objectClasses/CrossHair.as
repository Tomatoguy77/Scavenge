package objectClasses 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class CrossHair extends Sprite
	{
		[Embed(source="../../art/UI/crosshairs.png")]
		private var CrossHairArt:Class;
		
		//[Embed(source="../sound/gunShot.wav", mimeType="application/octet-stream")]
		private var gunshot:Sound;
		private var soundChannel:SoundChannel;
		
		private var art:Bitmap;
		public static const SHOOT:String = "SHOOT";
		
		public function CrossHair() 
		{
			//Mouse.hide();
			art = new CrossHairArt();
			addChild(art);
			this.scaleX = this.scaleY = 0.5;
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(MouseEvent.CLICK, onClick);
			
			gunshot = new Sound();
			//gunshot.load(new URLRequest("../sound/gunShot.mp3"));
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(CrossHair.SHOOT));
			//hier komt gunshot
			//soundChannel = gunshot.play(700,1)
			
		}
		
		private function loop (e:Event):void
		{
			this.x = stage.mouseX;
			this.y = stage.mouseY;
			art.x = -art.width / 2;
			art.y = -art.width / 2;
		}
		
	}

}