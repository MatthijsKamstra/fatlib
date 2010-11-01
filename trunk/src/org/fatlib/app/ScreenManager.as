package org.fatlib.app
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import org.fatlib.display.Text;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.Log;
	import org.fatlib.utils.DisplayUtils;
	
	/**
	 * This object manages a collection of screens. 
	 * Clients first register screens to be used. Then they can change which screen is shown.
	 * The ScreenManager is responsible for creating, destroying and rendering the screens.
	 */
	public class ScreenManager implements IDisplayable, IDestroyable
	{
		private var _currentScreen:Screen;
		private var _classReferences:Object;		// screen classes, keyed by name
		private var _display:DisplayObjectContainer;
		
		//private var _history:Array;
		
		/**
		 * Creates a new instance
		 */
		public function ScreenManager():void
		{
			Log.log("[ScreenManager] init");
			_display = new Sprite();
			_classReferences = { }
		//	_history = [];
		}
		
		///////////// PUBLIC
		
		
		public function get display():DisplayObjectContainer
		{
			return _display;
		}
		
		public function destroy():void
		{
			destroyScreen();
			_classReferences = null;
		}
		
		/**
		 * Register a screen class to be instatiated for a given name
		 * 
		 * @param	name		The name of the screen
		 * @param	screenClass	A subclass of Screen from which instances of this screen should be instatiated
		 */
		public function register(name:String, screenClass:Class):void
		{
			Log.log('[ScreenManager] registering screen ' + name + ' -> ' + screenClass);
			_classReferences[name] = screenClass;
		}
		
		/**
		 * Show the screen referenced by the given name
		 * 
		 * @param	name	The name of the screen to show
		 */
		public function goto(name:String, launchVars:Object=null, transition:String=null):void
		{
			destroyScreen();
			Log.log('[ScreenManager] showing screen ' + name);
			if (launchVars == null) launchVars = { };
		//	_history.push([name, launchVars, transition]);
			_currentScreen = createScreen(name);
			_currentScreen.launchVars = launchVars;
			_display.addChild(_currentScreen.display);
			if (display.stage) display.stage.focus = display.stage;
			_currentScreen.handleAdded();
		}
		
		/*
		public function back(transition:String = null):void
		{
			if (_history.length > 1)
			{
				_history.pop();
				var node:Array = _history[_history.length - 1];
				goto(node[0], node[1], node[2]);
			}
		}
		*/
		
		////////////////// PRIVATE
			
		private function destroyScreen():void
		{
			if (!_currentScreen) return;
			_currentScreen.handleRemoved();
			_display.removeChild(_currentScreen.display);
			_currentScreen.destroy();
		}
		
		///////
		
		private function createScreen(name:String):Screen
		{
			var scr:Screen;
			var ref:Class = _classReferences[name];	
			if (ref)
			{
				scr = new ref();
			} else {
				scr = createPlaceholderScreen(name);
			}
			scr.manager = this;
			scr.screenName = name;
			return scr;
		}
		
		private function createPlaceholderScreen(name:String):Screen
		{
			var scr:Screen = new Screen();
			var t:String = 'Placeholder for screen ' + name;
			scr.display.addChild(new Text(t));
			return scr;
		}

	}
	
}