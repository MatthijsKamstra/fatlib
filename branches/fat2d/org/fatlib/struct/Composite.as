package org.fatlib.struct 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IComposite;
	import org.fatlib.interfaces.IIterable;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.iterators.ArrayIterator;

	public class Composite extends Component implements IComposite, IIterable
	{

		private var _children:Array;
		private var _lookup:Object;
		
		private static var COMPONENT_ID:int = 0;
		
		public function Composite():void
		{
			_children = [];
			_lookup = { };
		}
		
		public function add(component:IComponent):void
		{
			if (!component.name) component.name = 'Component_' + COMPONENT_ID++;
			_lookup[component.name] = component;
			_children[component.name] = component;
			component.parent = this;
			if (_children.length == 0)
			{
				component.next = component;
				component.prev = component;
			} else {
				component.prev = _children[_children.length - 1];
				component.next = _children[0];
				(_children[_children.length - 1] as IComponent).next = component;
				(_children[0] as IComponent).prev = component;
			}
			_children.push(component);
		}
		
		public function remove(componentName:String):void
		{
			var comp:Component = _children[componentName];
			comp.parent = null;
			var left:IComponent= comp.prev;
			var right:IComponent = comp.next;
			comp.prev = null;
			comp.next = null;
			left.next = right;
			right.prev = left;
			_lookup[componentName] = null;
		}
		
		public function getChild(childName:String):IComponent
		{
			return _lookup[childName];
		}
		
		public function getIterator():IIterator
		{
			return new ArrayIterator(_children);
		}
	}
}