package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IComposite;

	public class Component implements IComponent
	{
		
		private var _name:String;
		private var _parent:IComposite;
		private var _next:IComponent;
		private var _prev:IComponent;
		
		public function Component() 
		{
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get parent():IComposite { return _parent; }
		
		public function set parent(value:IComposite):void 
		{
			_parent = value;
		}
		
		public function get next():* { return _next; }
		
		public function set next(value:IComponent):void 
		{
			_next = value;
		}
		
		public function get prev():* { return _prev; }
		
		public function set prev(value:IComponent):void 
		{
			_prev = value;
		}
		
		
	}

}