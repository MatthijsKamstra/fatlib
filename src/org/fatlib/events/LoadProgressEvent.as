package org.fatlib.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoadProgressEvent extends Event 
	{
		
		public static const LOADED:String = 'onLoaded';
		public static const ERROR:String = 'onError';
		public static const PROGRESS:String = 'onProgress';
		
		private var _percentLoaded:Number;
		private var _fractionLoaded:Number;
		private var _message:String;
		
		public function LoadProgressEvent(type:String, fractionLoaded:Number = 1, message:String=null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			
			_fractionLoaded = fractionLoaded;
			_percentLoaded = fractionLoaded * 100;
			
			_message = message;
		} 
		
		public override function clone():Event 
		{ 
			return new LoadProgressEvent(type, _fractionLoaded, _message, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LoadProgressEvent", "type", "fractionLoaded", "message", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get percentLoaded():Number { return _percentLoaded; }
		
		public function get fractionLoaded():Number { return _fractionLoaded; }
		
		public function get message():String { return _message; }
		
	}
	
}