package org.fatlib.interfaces 
{
	public interface IComponent 
	{
		function get name():String;
		function set name(n:String):void;
		function get parent():IComposite;
		function set parent(composite:IComposite):void;
		function get next():*;
		function set next(sibling:IComponent):void;
		function get prev():*;
		function set prev(sibling:IComponent):void;
	}
}