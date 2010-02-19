package org.fatlib.app
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import org.fatlib.display.Text;
	import org.fatlib.Log;
	import org.fatlib.utils.DisplayUtils;
	
	/**
	 * This object manages a collection of screens. 
	 * Clients first register screens to be used. Then they can change which screen is shown.
	 * The ScreenManager is responsible for creating, destroying and rendering the screens.
	 */
	public class ScreenManager extends Sprite
	{
		private var _currentScreen:Screen;
		private var _classReferences:Object;		// screen classes, keyed by name
		
		/**
		 * Creates a new instance
		 */
		public function ScreenManager():void
		{
			Log.log("[ScreenManager] init");
			_classReferences = { }
		}
		
		///////////// PUBLIC
		
		/**
		 * Register a screen class to be instatiated for a given name
		 * 
		 * @param	name		The name of the screen
		 * @param	screenClass	A subclass of Screen from which instances of this screen should be instatiated
		 */
		public function registerScreen(name:String, screenClass:Class):void
		{
			Log.log('[ScreenManager] registering screen ' + name + ' -> ' + screenClass);
			_classReferences[name] = screenClass;
		}
		
		/**
		 * Show the screen referenced by the given name
		 * 
		 * @param	name	The name of the screen to show
		 */
		public function changeScreen(name:String, launchVars:Object=null):void
		{
			destroyScreen();
			Log.log('[ScreenManager] showing screen ' + name);
			if (launchVars == null) launchVars = { };
			_currentScreen = createScreen(name);
			_currentScreen.launchVars = launchVars;
			addChild(_currentScreen);
			_currentScreen.handleAddedToStage();
		}
		
		////////////////// PRIVATE
		
		
			
		private function destroyScreen():void
		{
			if (!_currentScreen) return;
			Log.log('[ScreenManager] removing screen');
			DisplayUtils.recursiveStop(_currentScreen);
			_currentScreen.destroy();
			removeChild(_currentScreen);
			_currentScreen.handleRemovedFromStage();
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
			scr.screenName = name;
			return scr;
		}
		
		private function createPlaceholderScreen(name:String):Screen
		{
			var scr:Screen = new Screen();
			var t:String = 'Placeholder for screen ' + name;
			scr.addChild(new Text(t));
			return scr;
		}

	}
	
}