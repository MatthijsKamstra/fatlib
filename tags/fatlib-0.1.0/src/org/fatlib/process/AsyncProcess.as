package org.fatlib.process
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IProcess;
	
	/**
	 * An asynchronous process.
	 * 
	 * Dispatches an Event.COMPLETE event when done.
	 */
	public class AsyncProcess extends EventDispatcher implements IProcess, IDestroyable
	{
		[Event(name="complete", type="flash.events.Event")]
		
		public static const READY:String = 'READY';
		public static const EXECUTING:String = 'EXECUTING';
		public static const DONE:String = 'DONE';
		
		/**
		 * The current state of the process
		 */
		private var _state:String;
		
		/**
		 * Creates a new instance
		 */
		public function AsyncProcess() 
		{
			_state = READY;
		}
			
		/**
		 * Starts the process
		 */
		public function execute():void
		{
			_state = EXECUTING;
		}
		
		/**
		 * Terminates the process 
		 */
		public function terminate():void
		{
			_state = DONE;
		}
		
		/**
		 * Called when the object is no longer needed
		 */
		public function destroy():void
		{
		}
		
		/////////////
	
		/**
		 * Called when the process has finished naturally (ie. not terminated)
		 */
		final protected function done():void
		{
			_state = DONE;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
		public function get state():String { return _state; }
		
	}
}