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
	public class CheckBox extends AudioButtonBase
	{
		
		public static const ON_UP:String = 'on_up';
		public static const ON_OVER:String = 'on_over';
		public static const OFF_UP:String = 'off_up';
		public static const OFF_OVER:String = 'off_over';
		
		/**
		 * Is the checkbox checked or not?
		 */
		private var _checked:Boolean;
		
		private var _mouseOver:Boolean = false;
		
		/**
		 * Creates a new instance
		 * 
		 * @param	checked	Is it initially checked?
		 */
		public function CheckBox(checked:Boolean = false) 
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			addEventListener(MouseEvent.CLICK, onToggle, false, 0, true);
		
			_checked = checked;

			registerState(ON_UP);
			registerState(ON_OVER);
			registerState(OFF_UP);
			registerState(OFF_OVER);
			
			childrenInteractable = false;
			interactable = true;
			actAsButton = true;
			
			update();
		}
		
		
		override public function registerState(name:*, state:DisplayObject = null):void 
		{
			super.registerState(name, state);
			update();
		}
		
		public function get checked():Boolean { return _checked; }
		
		public function set checked(value:Boolean):void 
		{
			_checked = value;
			update();
		}
	
		private function onToggle(e:MouseEvent):void 
		{
			checked = !checked;
		}
			
		private function update():void
		{
			if (checked)
			{
				if (_mouseOver)
				{
					if (hasState(ON_OVER)) showState(ON_OVER);
				} else {
					if (hasState(ON_UP)) showState(ON_UP);
				}
			} else {
				if (_mouseOver)
				{
					if (hasState(OFF_OVER)) showState(OFF_OVER);
				} else {
					if (hasState(OFF_UP)) showState(OFF_UP);
				}
			}
		}
		

		private function onOut(e:MouseEvent):void 
		{
			_mouseOver = false;
			update();
		}
		
		private function onOver(e:MouseEvent):void 
		{
			_mouseOver = true;
			update();
		}
		
		
		

	}
	
}