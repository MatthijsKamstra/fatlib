package org.fatlib.process
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Thread extends MacroProcess
	{
		
		private var _frameSource:MovieClip;
		
		public function Thread() 
		{
			super();
			autoExecute = false;
			autoContinue = false;
			_frameSource = new MovieClip();
			_frameSource.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			if (state == AsyncProcess.READY )
			{
				if (_processes.length > 0)
				{
					execute();
				} 
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_frameSource.removeEventListener(Event.ENTER_FRAME, onFrame);
			_frameSource = null;
		}
		
	}

}