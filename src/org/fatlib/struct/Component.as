package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IComposite;

	public class Component implements IComponent
	{
		
		private var _name:String;
		private var _userData:Object;
		
		public function Component() 
		{
			_userData = { };
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	
		public function get userData():Object { return _userData; }
		
		public function set userData(value:Object):void 
		{
			_userData = value;
		}
		
	}

}