package org.fatlib.events
{
    import flash.events.Event;
   
	/**
	 * A general event with an untyped data field
	 */
    public class CustomEvent extends Event
    {
		
		private var _data:Object;
          
        public function CustomEvent(type:String, data:Object=null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            _data = data;
        }
       
        public override function clone():Event
        {
            return new CustomEvent(type, _data, bubbles, cancelable);
        }
       
 		public function get data():Object { return _data; }
		
		public override function toString():String
		{
            return formatToString("CustomEvent", "data", "type", "bubbles", "cancelable");
        }
		
   
    }
}