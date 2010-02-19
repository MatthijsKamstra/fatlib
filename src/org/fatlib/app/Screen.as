package org.fatlib.app
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.Log;
	import org.fatlib.utils.Delay;
	
	/**
	 * Represents a graphical screen of an application.
	 * 
	 * Subclass this class to implement your own application screens.
	 * 
	 * Managed by an instance of the ScreenManager class
	 */
	public class Screen extends Sprite implements IDestroyable
	{
		
		// A delay object
		protected var _delay:Delay;
		protected var _screenName:String;
		protected var _launchVars:Object = { };
		
		public function Screen() 
		{
			addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
			_delay = new Delay();
		}
		
		/**
		 * Called by ScreenManager when the screen is added to the stage
		 */
		public function handleAddedToStage():void
		{
		}
		
		/**
		 * Called by ScreenManage when the screen is removed from the stage
		 */
		public function handleRemovedFromStage():void
		{
		
		}
		
		
		public function get screenName():String { return _screenName; }
		
		public function set screenName(value:String):void 
		{
			_screenName = value;
		}
		
			
		public function set launchVars(value:Object):void 
		{
			_launchVars = value;
		}
	

		
		/**
		 *	Called when the screen is no longer needed
		 */
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onFrame);
			_delay.destroy();
		}

		
		///////
		
		
		/**
		 * Called every frame
		 */
		protected function handleFrame():void
		{
		}
			
		
		/////////
		
		private function onFrame(e:Event):void 
		{
			handleFrame();
		}
		
		
	}
	
}
