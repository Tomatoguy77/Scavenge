package backgroundProcess 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class ShakeThat extends MovieClip
	{
		public var ouch:Boolean = false;
		
		public function ShakeThat() 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void
		{
			addEventListener(Event.ENTER_FRAME, shake);
		}
		
		private function shake(e:Event):void 
		{
			if (ouch)
			{
				x = (Math.random()-.5)*10;
				y = (Math.random()-.5)*10;
			} else x = y = 0;
		}
	}
}