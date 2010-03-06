package org.fatlib.interfaces 
{
	public interface IComponent 
	{
		function get name():String;
		function set name(n:String):void;
		function get parent():IComposite;
		function set parent(composite:IComposite):void;
		function get next():IComponent;
		function set next(sibling:IComponent):void;
		function get prev():IComponent;
		function set prev(sibling:IComponent):void;
	}
}