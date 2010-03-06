package org.fatlib.interfaces 
{
	public interface IComposite 
	{
		function add(component:IComponent):void;
		function remove(componentName:String):void;
		function getChild(childName:String):IComponent;
	}
}