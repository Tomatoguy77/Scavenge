package backgroundProcess
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Scores extends TextField
	{
		private var _score:Number = 0;
		[Embed(source = "../../font/FSEX300.ttf",fontName="myFont",embedAsCFF="false")]
		private var font:Class;
		
		public function set score(s:Number):void
		{ 
			_score = s;
			this.text = "Score : " + _score;
		}
		public function get score():Number
		{
			return _score;
		}
		public function Scores() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			/*this.setTextFormat(new TextFormat(""))*/
			

		}
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.defaultTextFormat = new TextFormat("myFont",90,0xFFFFFF,true );
			this.width = stage.stageWidth;
			this.text = "Score : " + score;
		
			
			this.embedFonts = true;
		}
		
	}

}