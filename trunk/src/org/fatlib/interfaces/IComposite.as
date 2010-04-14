package org.fatlib.interfaces 
{
	public interface IComposite extends IComponent
	{
		function add(component:IComponent):void;
		function remove(component:IComponent):void;
		function removeByID(id:*):void;
		function getChild(id:*):*;
	}
}