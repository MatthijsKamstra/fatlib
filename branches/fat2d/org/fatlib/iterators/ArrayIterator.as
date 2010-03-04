package org.fatlib.iterators
{
	import org.fatlib.interfaces.IIterator;
	 
	/**
	 * Iterates over an array
	 */
	public class ArrayIterator implements IIterator
	{
		
		private var _position:int;
		private var _array:Array;
				
		/**
		 * Creates a new instance
		 * 	
		 * @param	arrayToIterateOver	The array to iterate over
		 */
		public function ArrayIterator(arrayToIterateOver:Array) 
		{
			_array=arrayToIterateOver;
			_position=0;
		}
		
		public function get next():*
		{
			var item:*=_array[position];
			_position++;
			return item;
		}
		
		public function get position():int
		{
			return _position;
		}
		
		public function get hasNext():Boolean
		{
			if (_position>=_array.length)
			{
				return false;
			} else {
				return true;
			}
		}
		
	}
	
}
