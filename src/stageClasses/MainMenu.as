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
	import objectClasses.CrossHair;
	//import backgroundProcess.Music;
	import UI_classes.Buttons;
	import UI_classes.Background;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class MainMenu extends Sprite
	{
		private var ship:Ship = new Ship;
		private var backMenu:menuLeeg = new menuLeeg;
		private var crossHair:CrossHair;
		private var i:int;
		private var backgroundScroller:Background = new Background();
		private var button:Buttons = new Buttons();
		//private var music:Music = new Music();
		private const openGame:String = "startGame";
		private const openCredits:String = "startCredits";
		private const openMenu:String = "startMenu";
		private const openInstruct:String = "startInstruct";
		private var backgrounds:Array;
		private var menuButtons:Array;
		public function MainMenu():void
		{
			
			//music.playMusic("../bin/bensound-dance(duringTheGame).mp3");
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			
			addEventListener(Event.ENTER_FRAME, respawnBack);
			addEventListener(MouseEvent.CLICK, onClick);
			//addChild(new CrateArt);
			backgrounds = new Array();
			menuButtons = new Array();
			addChild(backgroundScroller); 
			backMenu.x = stage.stageWidth * 0.3;
			backMenu.y = stage.stageHeight * 0.03;
			backMenu.scaleX = 0.9;
			addChild(backMenu);
			addChild(button);
			backgroundScroller.makeBackground(FullbackGround, 0, 0, 1, 1, backgrounds);
			//backgroundScroller.makeBackground(CrateArt, 1050, 500, backgrounds);
			button.makeBtn(howTo, (stage.stageWidth * 0.5 - 170),(stage.stageHeight * 0.45),menuButtons);
			button.makeBtn(playNow, (stage.stageWidth * 0.5 - 170),(stage.stageHeight * 0.35),menuButtons);
			button.makeBtn(highSc, (stage.stageWidth * 0.5 - 170),(stage.stageHeight * 0.55),menuButtons);
			//button.square((stage.stageWidth * 0.3),(stage.stageHeight * 0.5),100,100, 0xff0000, mainButtons);
			// entry point
			ship.x = 400;
			ship.y = 400;
			ship.rotationZ = 60;
			addChild(ship);
			
			//Mouse.cursor = crossHair;
			//crossHair = new CrossHair();
			//addChild(crossHair);
		}
		public function onClick(e:MouseEvent):void
		{
			if (e.target is playNow)
			{
				//music.stop();
				removeEventListener(Event.ADDED_TO_STAGE, init);
				dispatchEvent(new Event(openGame));
				trace("dit is een start button")
			}
			if (e.target is howTo)
			{
				//music.stop();
				removeEventListener(Event.ADDED_TO_STAGE, init);
				dispatchEvent(new Event(openInstruct));
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