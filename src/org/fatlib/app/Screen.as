package org.fatlib.app
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.fatlib.display.Graphic;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.Log;
	import org.fatlib.utils.Delay;
	import org.fatlib.utils.DisplayUtils;
	
	/**
	 * Represents a graphical screen of an application.
	 * 
	 * Subclass this class to implement your own application screens.
	 * 
	 * Managed by an instance of the ScreenManager class
	 */
	public class Screen implements IDisplayable, IDestroyable
	{
		
		// A delay object
		protected var _screenName:String;
		protected var _launchVars:Object = { };
		protected var _display:DisplayObjectContainer;
		protected var _delay:Delay;
		private var _manager:ScreenManager;
		
		public function Screen() 
		{
			_delay = new Delay();
			_display = new Sprite();
			_display.addEventListener(MouseEvent.CLICK, onClick);
			_display.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		
		
		/**
		 * Called by ScreenManager when the screen is added to the stage
		 */
		public function handleAdded():void
		{
		}
		
		/**
		 * Called by ScreenManager when the screen is removed from the stage
		 */
		public function handleRemoved():void
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
		
		public function get display():DisplayObjectContainer { return _display; }
		
		final public function set manager(value:ScreenManager):void 
		{
			_manager = value;
		}
		
		public function destroy():void
		{
			_display.removeEventListener(MouseEvent.CLICK, onClick);
			_display.removeEventListener(Event.ENTER_FRAME, onFrame);
			_delay.destroy();
			DisplayUtils.recursiveStop(_display);
		}
		
		///////////
		
		
		protected function handleClicked(targetName:String):void
		{
		}
		
		protected function handleFrame():void
		{
			
		}
		
		
		protected function gotoScreen(screenName:String, launchVars:Object=null, transition:String = null):void
		{
			_manager.goto(screenName, launchVars, transition);
		}
	
		/*
		final protected function goBack():void
		{
			_manager.back();
		}
		*/
		
		////////
		
		private function onClick(e:MouseEvent):void 
		{
			handleClicked(e.target.name);
		}
		
		private function onFrame(e:Event):void 
		{
			handleFrame();
		}
		
		
		

		
	}
	
}
