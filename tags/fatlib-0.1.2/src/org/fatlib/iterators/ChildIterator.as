package org.fatlib.iterators
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import org.fatlib.interfaces.IIterator;
	 
	/**
	 * Non-recursively iterates through the children of a DisplayObjectContainer.
	 * When created it makes a copy of the children to iterate through
	 */
	public class ChildIterator extends ArrayIterator
	{
		
		private var _position:int;
		private var _childList:Array;

		/**
		 * Creates a new instance
		 * 
		 * @param	s	The DisplayObjectContainer to iterate over
		 */
		public function ChildIterator(obj:DisplayObjectContainer) 
		{
			var childList:Array = new Array();
			for (var i:int = 0; i < obj.numChildren; i++)
				childList.push(obj.getChildAt(i));
			super(childList);
		}
		
	}
	
}
