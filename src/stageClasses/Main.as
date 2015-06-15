package stageClasses
{
	import enemies.Enemy11;
	import enemies.Enemy3;
	import enemies.Enemy4;
	import enemies.EnemyMove;
	import enemies.EnemyShip11;
	import enemies.RandMove;
	import enemies.RandMove2;
	import enemies.Shoot;
	import enemies.Shoot2;
	import enemies.Shoot3;
	import enemies.Shoot4;
	import backgroundProcess.Scores;
	import backgroundProcess.ShakeThat;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	//import backgroundProcess.Music;
	import backgroundProcess.Vector2D;
	import objectClasses.Player;
	import UI_classes.Buttons;
	import UI_classes.Background;	

	
	
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Main extends Sprite
	{
		private var pouseTimer:int;
		private var clipFrame:int;
		private var clipBlue:blueClip = new blueClip();
		private var clipGreen:greenClip = new greenClip();
		private var clipOcean:oceanClip = new oceanClip();
		private var clipPink:pinkClip = new pinkClip();
		private var clipRed:redClip = new redClip();
		private var clipYellow:yellowClip = new yellowClip();
		private var hpBar:Hp = new Hp();
		private var pouse:Boolean = true;
		private var speed:int = 1;
		private var keynum:Boolean = false;
		private var timer:int ;
		private var backgrounds:Array;
		private var mainButtons:Array;
		private var backgroundScroller:Background = new Background();
		//private var music:Music = new Music;
		private var button:Buttons = new Buttons();
		private var myTimer:Timer;
		private var myTimer2:Timer;
		private var myTimer3:Timer;
		private var myTimer4:Timer;
		public static var myShip:Player;
		public static var input:Point = new Point();
		private var round:int = 1;
		private var statScreen1:TankTurret =  new TankTurret();
		private var menuScreen:menuLeeg = new menuLeeg();
		private var shake:ShakeThat;
		private var scoreboard:Scores;
		public var upgrade:Shape;
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
		private var myTimer11:Timer = new Timer(2000, 0);
		private var enemyShip1:EnemyShip11 = new EnemyShip11();
		private var isShooting:Boolean = false;
		
		public var sEnemyX:Number;
		public var sEnemyY:Number;
		
		private var enemy3:Enemy3 = new Enemy3();
		private var enemy4:Enemy4 = new Enemy4();
		private var shoot2:Shoot2 = new Shoot2();
		private var shoot3:Shoot3 = new Shoot3();
		
		public function Main():void
		{
			//music.playMusic("../../music/bensound-dance(duringTheGame).mp3");
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		//all addchilds
		public function init(e:Event = null):void
		{
			
			Mouse.hide();
			input.y = -1;
			
			shake = new ShakeThat();
			stage.addChild(shake);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, respawnBack);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			
			myTimer = new Timer(20, 200);
			myTimer.addEventListener(TimerEvent.TIMER, updateTime);
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer);
			
			myTimer2 = new Timer(20, 200);
			myTimer2.addEventListener(TimerEvent.TIMER, updateTime2);
			myTimer2.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer2);
			
			myTimer3 = new Timer(20, 25);
			myTimer3.addEventListener(TimerEvent.TIMER, updateTime3);
			myTimer3.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer3);
			
			myTimer4 = new Timer(20, 25);
			myTimer4.addEventListener(TimerEvent.TIMER, updateTime4);
			myTimer4.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer4);
			
			myShip = new Player();
			myShip.x = stage.stageWidth * 0.5;
			myShip.y = stage.stageHeight * 0.5;
			myShip.scaleX = 0.5;
			myShip.scaleY = 0.5;
			
			statScreen1.x = -200;
			statScreen1.y = stage.stageHeight * 0.5;
			
			menuScreen.x = 2000;
			menuScreen.scaleX = 1;
			menuScreen.scaleY = 1;
			
			addEventListener(Event.ENTER_FRAME, loop);
			
			addEventListener(MouseEvent.CLICK, onClick);
			backgrounds = new Array();
			mainButtons = new Array();
			shake.addChild(backgroundScroller);
			shake.addChild(button);
			backgroundScroller.makeBackground(backgrWhole, -2880, -1620, 1, 1, backgrounds);
			backgroundScroller.makeBackground(backgrWhole, -2880, 540, 1, 1, backgrounds);
			backgroundScroller.makeBackground(backgrWhole, 960, -1620, 1, 1, backgrounds);
			backgroundScroller.makeBackground(backgrWhole, 960, 540, 1, 1, backgrounds);
			upgrade = new Shape(); 
			
			upgrade.graphics.beginFill(0xFF0000); 
			upgrade.graphics.drawRect(0, 0, 100,100);
			upgrade.graphics.endFill();
			upgrade.x = stage.stageWidth / 2;
			upgrade.y = 200;
			upgrade.scaleX = 0.5;
			upgrade.scaleY = 0.5;
			
			addEventListener(Event.ENTER_FRAME, update);
			//	addChild(randMove);
			shake.addChild(randMove2);
			shake.addChild(enemyShip1);
			shake.addChild(enemy3);
			shake.addChild(enemy4);
			myTimer.addEventListener(TimerEvent.TIMER, TimeListen);
			//eventlisteners
			myTimer11.start();
			//enemyShip1.createEnemy(enemies);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//addChild(shoot);
			// entry point}
			shake.addChild(upgrade);
			shake.addChild(myShip);
			shake.addChild(statScreen1);
			shake.addChild(menuScreen);
			scoreboard = new Scores;
			shake.addChild(scoreboard);
			scoreboard.x = stage.stageWidth * 0.5 - 200;
			hpBar.x = 0 ;
			hpBar.y = stage.stageHeight * -0.01;
			hpBar.scaleX = 1.3;
			hpBar.scaleY = 1.3;
			shake.addChild(hpBar);
			
			clipBlue.scaleX = 0.4;
			clipBlue.scaleY = 0.4;
			clipBlue.x = stage.stageWidth * 0.927;
			clipBlue.y = stage.stageHeight * 0.27;
			
			clipGreen.scaleX = 0.4;
			clipGreen.scaleY = 0.4;
			clipGreen.x = stage.stageWidth * 0.88;
			clipGreen.y = stage.stageHeight * 0.09;
			
			clipOcean.scaleX = 0.4;
			clipOcean.scaleY = 0.4;
			clipOcean.x = stage.stageWidth * 0.938;
			clipOcean.y = stage.stageHeight * 0.32;
			
			clipPink.scaleX = 0.4;
			clipPink.scaleY = 0.4;
			clipPink.x = stage.stageWidth * 0.945;
			clipPink.y = stage.stageHeight * 0.37;
			
			clipRed.scaleX = 0.4;
			clipRed.scaleY = 0.4;
			clipRed.x = stage.stageWidth * 0.892;
			clipRed.y = stage.stageHeight * 0.22;
			
			clipYellow.scaleX = 0.25;
			clipYellow.scaleY = 0.3;
			clipYellow.x = stage.stageWidth * 0.88;
			clipYellow.y = stage.stageHeight * 0.17;
			
			shake.addChild(clipBlue);
			shake.addChild(clipGreen);
			shake.addChild(clipOcean);
			shake.addChild(clipPink);
			shake.addChild(clipRed);
			shake.addChild(clipYellow);
			hpBar.gotoAndStop(40);
			clipBlue.gotoAndStop(21);//max 21
			clipGreen.gotoAndStop(51);//max 51
			clipOcean.gotoAndStop(16);//max 16
			clipPink.gotoAndStop(16);//max 16
			clipRed.gotoAndStop(31);//max 31
			clipYellow.gotoAndStop(56);//max 56
			myShip.myTankBody.gotoAndStop(1);
			shake.addChild(button);
			button.makeBtn(back, 2000, stage.stageHeight * 0.7, mainButtons);
			
		}
		
		private function loop(e:Event):void
		{
			trace(myShip.lives);
			hpBar.gotoAndStop(myShip.lives);
			//ship stuff
			if (myShip != null)
			{
				myShip.updates();
				if (myShip.lives >= 40)
				{
					myShip.removeEntity();
					//shake.removeChild(myShip);
					//myShip = null;
					
				}
			}
			
			//for smooth movement, rotate not included
			speed = timer;
			if (keynum == true)
			{
				timer ++;
				if (timer >= 46)
				{
					timer = 45;
				}
			}
			if (keynum == false)
			{
				timer = timer - 1;
				if (timer <= 0)
				{
					timer = 0;
				}
			}
			//actual movement
			var r:Number = myShip.rotation * Math.PI / 180;
			var xMove:Number = Math.cos(r)* speed;
			var yMove:Number = Math.sin(r) * speed;
			
			if (myShip.hitTestObject(upgrade))
			{
				myShip.myTankBody.gotoAndStop(12);
				myTimer.start();
				myShip.lives += 10;
				scoreboard.score ++;
				clipBlue.gotoAndStop(1);
				
				upgrade.x = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
				upgrade.y = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
				//if(upgrade.parent != null){
					//upgrade.parent.removeChild(upgrade);
				//}
			}
			if (upgrade)
			{
				upgrade.x += Main.input.y * xMove ;
				upgrade.y += Main.input.y * yMove ;
			}
			
			//trace(backgrounds[0].width + "++++" + backgrounds[0].height);
			for (var i:int = 0; i < backgrounds.length; i++)
			{
				backgrounds[i].x += int(Main.input.y * xMove) ;
				backgrounds[i].y += int(Main.input.y * yMove) ;
				if (backgrounds[i].x > backgrounds[i].width)
				{
					backgrounds[i].x -= (backgrounds[i].width * 2);// - 1;
				}
				else if (backgrounds[i].x < -backgrounds[i].width)
				{
					backgrounds[i].x += (backgrounds[i].width * 2);// + 1;
				}
				if (backgrounds[i].y > backgrounds[i].height)
				{
					backgrounds[i].y -= (backgrounds[i].height * 2);// - 1;
				}
				else if (backgrounds[i].y < -backgrounds[i].height)
				{
					backgrounds[i].y += (backgrounds[i].height * 2);// + 1;
				}
				
				
			}
			
		}
		
		public function onClick(e:MouseEvent):void
		{
			if (e.target is CrateArt)
			{
				
			}
		}
		
		private function respawnBack(e:KeyboardEvent):void
		{
			//pouse knop
			if (e.keyCode == Keyboard.P)
			{
				
				if (pouse == true)
				{
					removeEventListener(Event.ENTER_FRAME, update);
					removeEventListener(Event.ENTER_FRAME, loop);
					Mouse.show();
					myTimer3.start();
					keynum = false;
					//pouseTimer = timer;
					//timer = 0;
					
				}
				if (pouse == false)
				{
					addEventListener(Event.ENTER_FRAME, update);
					addEventListener(Event.ENTER_FRAME, loop);
					Mouse.hide();
					keynum = true;
					myTimer4.start();
					//timer = pouseTimer;
				}
				pouse = !pouse;
			}
			
			//movement input
			if (pouse == true)
			{
				if (e.keyCode == Keyboard.SPACE)
				{
					
				}
				if (e.keyCode == Keyboard.W)
				{
					keynum = true;
				}
				if (e.keyCode == Keyboard.A)
				{
					input.x = -1;
					//keynum2 = true;
				}
				if (e.keyCode == Keyboard.D)
				{
					//keynum2 = true;
					input.x = 1;
				}
				if (e.keyCode == Keyboard.S)
				{
					
				}
			}	
		}
		
		private function keyRelease(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W)
			{
				keynum = false;
				//input.y = 0;
			}
			if (e.keyCode == Keyboard.S)
			{
				//input.y = 0;
			}
			if (e.keyCode == Keyboard.A)
			{
				input.x = 0;
				//keynum2 = false;				
			}
			if (e.keyCode == Keyboard.D)
			{
				input.x = 0;
				//keynum2 = false;
			}
		}
		//timer 1 and 2 are for upgrade clarity
		private function endTimer(e:TimerEvent):void
		{
			myTimer2.start();
		}
		private function updateTime(e:TimerEvent):void
		{
			shake.ouch = true;//let it shake
			//myShip.lives ++;
			statScreen1.x += 2;
			if (statScreen1.x > 50)
			{
				statScreen1.x = 50;
			}
		}
		private function endTimer2(e:TimerEvent):void
		{
			shake.ouch = false;//i demand you stop shaking now
			myTimer.reset();
			myTimer2.reset();
		}
		private function updateTime2(e:TimerEvent):void
		{
			statScreen1.x += -2;
			if (statScreen1.x < -200)
			{
				statScreen1.x = -200;
			}
			
		}
		//timer 3 and 4 for the menuscreen 
		private function endTimer3(e:TimerEvent):void
		{
			
		}
		private function updateTime3(e:TimerEvent):void
		{
			menuScreen.x += -100;
			if (menuScreen.x < stage.stageWidth * 0.27)
			{
				menuScreen.x = stage.stageWidth * 0.27;
			}
			mainButtons[0].x += -100;
			if (mainButtons[0].x < stage.stageWidth * 0.51)
			{
				mainButtons[0].x = stage.stageWidth * 0.51;
			}
		}
		private function endTimer4(e:TimerEvent):void
		{
			myTimer3.reset();
			myTimer4.reset();
		}
		private function updateTime4(e:TimerEvent):void
		{
			menuScreen.x += 100;
			if (menuScreen.x > 2000)
			{
				menuScreen.x = 2000;
			}
			mainButtons[0].x += 100;
			if (mainButtons[0].x > 2000)
			{
				mainButtons[0].x = 2000;
			}
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