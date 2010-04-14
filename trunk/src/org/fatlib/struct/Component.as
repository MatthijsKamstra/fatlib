package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;

	public class Component implements IComponent
	{
		
		private var _id:*;
		
		public function Component() 
		{
		}
		
		public function get id():* { return _id; }
		
		public function set id(value:*):void 
		{
			_id = value;
		}
		
		
	}

}