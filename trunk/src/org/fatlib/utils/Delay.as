package org.fatlib.utils 
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.process.Callback;

	/**
	 * Provides delays / timeouts.
	 * 
	 * Use it like this:
	 * 
	 * var d:Delay=new Delay();
	 * d.create(1000, showText, ['hello']);
	 * 
	 * function showText(text:String)
	 * {
	 * 		trace(text);
	 * }
	 * 
	 *  
	 */
	public class Delay implements IDestroyable
	{
		/**
		 * A dictionary of active delay instances 
		 */
		private var _index:Dictionary;
			
		/**
		 * Creates a new instance
		 */
		public function Delay() 
		{
			_index=new Dictionary(true);//uses weak keys
		}
		
		/**
		 * Creates a new delay object
		 * 
		 * @param	ms					The numbed of milliseconds to wait
		 * @param	onComplete			The methed to call when finished
		 * @param	onCompleteParams	An array of parameters to pass to the onComplete method
		 */
		public function create(ms:int, onComplete:Function, onCompleteParams:Array = null):void
		{
			var callback:Callback=new Callback(onComplete, onCompleteParams);
			var t:Timer=new Timer(ms,1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerFinished);
			_index[t] = callback;
			t.start();
		}
		
		/**
		 * Cancels all active delays
		 */
		public function cancelAll():void
		{
			for (var t:* in _index)
				cancel(t);
		}
		
		
		/**
		 * Destroys the object. Call this when you've finished using it.
		 */
		public function destroy():void
		{
			for (var t:Object in _index)
			{
				(t as Timer).stop();
				delete _index[t];
			}
		}
		
		////////// PRIVATE METHODS
		
		private function cancel(t:Timer):void
		{
			if (!t || !_index[t]) return;
			t.stop();
			t.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerFinished);
			_index[t] = null;
			delete _index[t];
			t = null;
		}
				
		private function onTimerFinished(e:TimerEvent):void
		{
			var t:Timer=e.currentTarget as Timer;
			var callback:Callback=_index[t] as Callback;
			callback.execute();
			t.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerFinished);
			_index[t] = null;
			delete _index[t];
			t=null;
		}

		
	}
	
}
