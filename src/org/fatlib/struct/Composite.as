package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IComposite;
	import org.fatlib.interfaces.IIterable;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.iterators.ArrayIterator;
	import org.fatlib.utils.ArrayUtils;

	public class Composite extends Component implements IComposite
	{

		private var _lookup:Object;
		private var _children:Array
		private var _numChildren:uint = 0;
		
		private static var COMPONENT_ID:int = 0;
		
		public function Composite():void
		{
			_lookup = { };
			_children = [];
		}
		
		public function add(component:IComponent):void
		{
			if (!component.id) component.id = 'Component_' + COMPONENT_ID++;
			_lookup[component.id] = component;
			_children.push(component);
			_numChildren++;
		}
		
		public function remove(component:IComponent):void
		{
			if (_lookup[component.id])
			{
				ArrayUtils.remove(_children, component);
				delete _lookup[component.id];
				_numChildren--;
			}
		}
		
		public function removeByID(id:*):void
		{
			var comp:Component = getChild(id);
			if (!comp) return;
			remove(comp);
		}
		
		public function hasChild(id:*):Boolean
		{
			return _lookup[id] != null;
		}
		
		public function getChild(id:*):*
		{
			return _lookup[id];
		}
		
		public function get numChildren():uint
		{
			return _numChildren;
		}
		
		public function getIterator():IIterator
		{
			return new ArrayIterator(_children);
		}
		
	}
}