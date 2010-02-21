package org.fatlib.app
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.fatlib.display.Graphic;
	import org.fatlib.interfaces.ICanvas;
	import org.fatlib.interfaces.IDestroyable;
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
	public class Screen implements ICanvas, IDestroyable
	{
		
		// A delay object
		protected var _screenName:String;
		protected var _launchVars:Object = { };
		protected var _canvas:DisplayObjectContainer;
		protected var _delay:Delay;
		private var _manager:ScreenManager;
		
		public function Screen() 
		{
			_delay = new Delay();
			_canvas = new Sprite();
			_canvas.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
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
		
		protected function handleClicked(targetName:String):void
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
		
		public function get canvas():DisplayObjectContainer { return _canvas; }
		
		final public function set manager(value:ScreenManager):void 
		{
			_manager = value;
		}
		
		public function destroy():void
		{
			DisplayUtils.recursiveStop(_canvas);
		}
		
		///////////
		
		protected function gotoScreen(screenName:String, launchVars:Object=null, transition:String = null):void
		{
			_manager.changeScreen(screenName, launchVars, transition);
		}
		
		
		////////
		
		private function onClick(e:MouseEvent):void 
		{
			handleClicked(e.target.name);
		}
		

		
	}
	
}
