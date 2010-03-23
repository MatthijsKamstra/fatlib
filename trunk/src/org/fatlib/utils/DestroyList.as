package org.fatlib.utils
{
	import org.fatlib.interfaces.IDestroyable;

	
	/**
	 * A list of items which implement the IDestroyable interface, so that 
	 * lots of items can be destroyed at once
	 */
	public class DestroyList implements IDestroyable
	{

		private var _list:Array;
		
		/**
		 * creates a new instance of the class
		 */
		public function DestroyList() 
		{
		}
		
		/**
		 * Adds items to the list
		 * @param	...args	Any number of items that implement the IDestroyable interface
		 */
		public function add(...args):void
		{
			if (!_list)
				_list = new Array();
				
			for each(var i:Object in args)
			{
				if (!(i is IDestroyable))throw new Error(i + ' does not implement IDestroyable');
				_list.push(i);
			}
		}
		
		/**
		 * Destroys all the items in the list
		 */
		public function destroy():void
		{
			for each(var i:IDestroyable in _list)
			{
				i.destroy();
				i = null;
			}
			_list = null;
		}
		
	}
	
}
