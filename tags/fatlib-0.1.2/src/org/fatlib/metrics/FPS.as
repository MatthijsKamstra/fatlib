package org.fatlib.metrics 
{
	import flash.display.*
	import flash.text.*
	import flash.geom.Point;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * A simple FPS counter 
	 */
	public class FPS extends Sprite 
	{
		private var checkRate:int=8;
		private var checkCounter:int;
		private var startTime:Number;
		private var t:TextField;
		
		public function FPS():void
		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0x00CCFF;
			tf.font = '_sans';
			t = new TextField();
			t.defaultTextFormat = tf;
			t.selectable = false;
			t.mouseEnabled = false;
									
			addChild(t);
			checkCounter = checkRate;
			startTime = getTimer();
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(event:Event):void
		{
			if (--checkCounter == 0) 
			{
				var fr:Number = checkRate/((getTimer() - startTime)/1000);
				fr = Math.round((fr * 10) / 10);
				t.text = fr.toString();
				startTime = getTimer();
				checkCounter = checkRate;
			}
		}
	}
}