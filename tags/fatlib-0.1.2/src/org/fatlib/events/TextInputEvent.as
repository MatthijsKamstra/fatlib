package org.fatlib.events 
{
	import flash.events.Event;
	
	public class TextInputEvent extends Event 
	{
		
		public static const TEXT_INPUT:String = 'onTextInput';
		
		private var _text:String;
		
		public function TextInputEvent(type:String, text:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_text = text;
		} 
		
		public override function clone():Event 
		{ 
			return new TextInputEvent(type, _text, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TextInputEvent", "text", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get text():String { return _text; }
		
	}
	
}