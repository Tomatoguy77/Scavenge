package stageClasses {
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import backgroundProcess.Music;
	import UI_classes.Buttons;
	import UI_classes.Background;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class InstructPage extends Sprite 
	{
		private var backgrounds:Array;
		private var mainButtons:Array;
		private var backgroundScroller:Background = new Background();
		private var instr:InstructPage;
		private var music:Music = new Music();
		private const openMenu:String = "startMenu";
		private var button:Buttons = new Buttons();
		
		public function InstructPage():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			addEventListener(Event.ENTER_FRAME, respawnBack);
			addEventListener(MouseEvent.CLICK, onClick);
			//addChild(new CrateArt);
			backgrounds = new Array();
			mainButtons = new Array();
			addChild(backgroundScroller);
			addChild(button);
			backgroundScroller.makeBackground(FullbackGround, 0, 0, 1, 1, backgrounds);
			backgroundScroller.makeBackground(instructMenu, stage.stageWidth * 0.2, -50, 1.4, 1.4, backgrounds);
			button.makeBtn(back, (stage.stageWidth * 0.81),(stage.stageHeight * 0.89),mainButtons);
		}
		public function onClick(e:MouseEvent):void
		{
			if (e.target is back)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
				dispatchEvent(new Event (openMenu));
				//stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				//music.stop();
				parent.removeChild(this);
				instr = null;
				trace("test");
			}
		}
		
		public function respawnBack(e:Event):void
		{
			for (var i = 0; i < backgrounds.length; i++)
			{
				if (backgrounds[i].x >= 1000)
				{
					backgrounds[i].x = 500;
				}	
			}
		}
	}
}