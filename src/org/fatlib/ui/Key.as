package org.fatlib.ui 
{
   
	import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
   
	/**
	 * Used to check whether keys are being pressed
	 */
    public class Key 
	{
       
        private static var _inited:Boolean = false; 
        private static var _keysDown:Object;
       
		/**
		 * Use WASD keys for directional inputs?
		 */
		private static var _wasd:Boolean = true;
		
        /**
         * Initializes the key class creating assigning event
         * handlers to capture necessary key events from the stage
         */
        public static function init(target:Stage):void 
		{
            if (!_inited)
			{
				_keysDown = { };
	            target.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
                target.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
                target.addEventListener(Event.DEACTIVATE, clearKeys);
				_inited = true;
            }
        }
       
		/**
		 * Is the key with the supplied keycode being pressed?
		 * 
		 * @param	keyCode	The keycode to check
		 * @return	Whether the key is being pressed
		 */
        public static function isDown(keyCode:uint):Boolean {
            if (!_inited)  throw new Error("Key class has yet been inited.");
            return Boolean(keyCode in _keysDown);
        }
		
		/**
		 * Is the current character being pressed?
		 * 
		 * @param	char	A string who's first character to check
		 * @return	Whether the key is being pressed
		 */
		public static function isCharDown(char:String):Boolean
		{
			if (!_inited) throw new Error("Key class has yet been inited.");
			return isDown(char.charCodeAt(0));
		}
		
		/////////

		/**
		 * Is the LEFT key down?
		 */
		public static function get left():Boolean
		{
			return isDown(Keyboard.LEFT) || (isDown(65) && _wasd);	  // A
		}
		
		/**
		 * Is the RIGHT key down?
		 */
		public static function get right():Boolean
		{
			return isDown(Keyboard.RIGHT) || (isDown(68) && _wasd);   // D
		}
		
		/**
		 * Is the UP key down?
		 */
		public static function get up():Boolean
		{
			return isDown(Keyboard.UP) || (isDown(87) && _wasd);   // W
		}
		
		/**
		 * Is the DOWN key down?
		 */
		public static function get down():Boolean
		{
			return isDown(Keyboard.DOWN) || (isDown(83) && _wasd);   // S
		}
		
		/**
		 * Is the SHIFT key down?
		 */
		public static function get shift():Boolean
		{
			return isDown(Keyboard.SHIFT);
		}
		
		/**
		 * Is the CTRL key down?
		 */
		public static function get ctrl():Boolean
		{
			return isDown(Keyboard.CONTROL);
		}
		
		/**
		 * Is the SPACE key down?
		 */
		public static function get space():Boolean
		{
			return isDown(Keyboard.SPACE);
		}
		
		/**
		 * Is the ENTER key down?
		 */
		public static function get enter():Boolean
		{
			return isDown(Keyboard.ENTER);
		}
		
		/**
		 * Use WASD for directional input?
		 */
		static public function set wasd(value:Boolean):void 
		{
			_wasd = value;
		}
		
        private static function keyPressed(event:KeyboardEvent):void 
		{
            _keysDown[event.keyCode] = true;
        }
       
        private static function keyReleased(event:KeyboardEvent):void {
            if (event.keyCode in _keysDown)  delete _keysDown[event.keyCode];
        }
       
        /**
         * Event handler for Flash Player deactivation
         */
        private static function clearKeys(event:Event):void {
            // clear all keys in keysDown since the player cannot
            // detect keys being pressed or released when not focused
            _keysDown = { };
        }
    }
}