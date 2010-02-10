package org.fatlib.assets 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoadProgressEvent extends Event 
	{
		
		private var _percentLoaded:Number;
		private var _fractionLoaded:Number;
		
		public function LoadProgressEvent(type:String, fractionLoaded:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_fractionLoaded = fractionLoaded;
			_percentLoaded = fractionLoaded * 100;
		} 
		
		public override function clone():Event 
		{ 
			return new LoadProgressEvent(type, _fractionLoaded, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LoadProgressEvent", "fractionLoaded", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get percentLoaded():Number { return _percentLoaded; }
		
		public function get fractionLoaded():Number { return _fractionLoaded; }
		
	}
	
}