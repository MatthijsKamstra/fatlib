package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IComposite;

	public class Component implements IComponent
	{
		
		private var _name:String;
		private var _parent:IComposite;
		private var _userData:Object;
		private var _next:IComponent;
		private var _prev:IComponent;
		
		public function Component() 
		{
			_userData = { };
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
		
		public function get next():IComponent { return _next; }
		
		public function set next(value:IComponent):void 
		{
			_next = value;
		}
		
		public function get prev():IComponent { return _prev; }
		
		public function set prev(value:IComponent):void 
		{
			_prev = value;
		}
		
		public function get userData():Object { return _userData; }
		
		public function set userData(value:Object):void 
		{
			_userData = value;
		}
		
	}

}