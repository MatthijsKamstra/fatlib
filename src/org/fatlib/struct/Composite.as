package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IComposite;
	import org.fatlib.interfaces.IIterable;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.iterators.ArrayIterator;

	public class Composite extends Component implements IComposite, IIterable
	{

		protected var _lookup:Object;
		private var _numChildren:uint = 0;
		
		private static var COMPONENT_ID:int = 0;
		
		public function Composite():void
		{
			_lookup = { };
		}
		
		public function add(component:IComponent):void
		{
			if (!component.name) component.name = 'Component_' + COMPONENT_ID++;
			_lookup[component.name] = component;
			_numChildren++;
		}
		
		public function remove(childName:String):void
		{
			var comp:Component = getChild(childName);
			if (!comp) return;
			_lookup[childName] = null;
			_numChildren--;
		}
		
		public function getChild(childName:String):*
		{
			return _lookup[childName];
		}
		
		public function get numChildren():uint
		{
			return _numChildren;
		}
		
		public function getIterator():IIterator
		{
			var a:Array = [];
			for each(var c:IComponent in _lookup)
				a.push(c);
			return new ArrayIterator(a);
		}
		
	}
}