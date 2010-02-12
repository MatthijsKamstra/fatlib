package org.fatlib.display 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.fatlib.Log;
	
	/**
	 * A checkbox implementation subclassing Graphic
	 * 
	 * Defined by 4 states - 
	 * 	on_up: The up state of the 'on' state
	 * 	on_over: The over state of the 'on' state
	 * 	off_up: The up state of the 'off' state
	 * 	off_over: The over state of the 'off' state
	 * 
	 */
	public class CheckBox extends Graphic
	{
		public static const ON:String = 'on';
		public static const OFF:String = 'off';
		
		public static const ON_UP:String = 'on_up';
		public static const ON_OVER:String = 'on_over';
		public static const OFF_UP:String = 'off_up';
		public static const OFF_OVER:String = 'off_over';
		
		/**
		 * Is the checkbox checked or not?
		 */
		private var _checked:Boolean;
		
		private var _onButton:Button;
		private var _offButton:Button;
			
		/**
		 * Creates a new instance
		 * 
		 * @param	checked	Is it initially checked?
		 */
		public function CheckBox(checked:Boolean) 
		{
			super();
			
			_onButton = new Button();
			_offButton = new Button();
			
			_onButton.addEventListener(MouseEvent.CLICK, onToggle);
			_offButton.addEventListener(MouseEvent.CLICK, onToggle);
			
			registerState(ON, _onButton);
			registerState(OFF, _offButton);
			
			_checked = checked;
			updateState();
		}
		
		public function get checked():Boolean { return _checked; }
		
		public function set checked(value:Boolean):void 
		{
			_checked = value;
			updateState();
		}
		
		
		private function updateState():void
		{
			if (_checked)
			{
				showState(ON);
			} else {
				showState(OFF);
			}
		}
		
		private function onToggle(e:MouseEvent):void 
		{
			_checked = !_checked;
			updateState();
		}
		

		override public function registerState(key:*, state:DisplayObject=null):void 
		{
			switch(key)
			{
				case ON_OVER:
					_onButton.registerState(Button.OVER, state);
					break;
				case ON_UP:
					_onButton.registerState(Button.UP, state);
					break;
				case OFF_OVER:
					_offButton.registerState(Button.OVER, state);
					break;
				case OFF_UP:
					_offButton.registerState(Button.UP, state);
					break;
				case BLANK:
				case ON:
				case OFF:
					super.registerState(key, state);
					break;
				default:
					Log.log("[CheckBox] Unknown state:" + key);
					break;
			}
			
		}
	
		public function get onButton():Button { return _onButton; }
		public function get offButton():Button { return _offButton; }
	
		
	}
	
}