package org.fatlib.utils
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * Provides Array helper methods
	 * */
	public class ArrayUtils
	{
		
		/**
		 * Returns a shuffled copy of a given array
		 * 
		 * @param	arrayToShuffle	The array to shuffle
		 * @return	A shuffled copy of the array
		 */
		public static function shuffle(arrayToShuffle:Array):Array 
		{
			var copy:Array = arrayToShuffle.concat();
			var shuffled:Array = new Array();
			var element:Object;
			
			for(var i:int = 0; i < copy.length; i++) 
			{
			  var num:int = Math.floor(Math.random()*(copy.length));
			  shuffled.push(copy[num]);
			  copy.splice(num, 1);
			  i--;
			}
			return shuffled;
		}
		
		/**
		 * Check wheter a given array contains a given element
		 * @param	a		The array to search
		 * @param	element	The element to search for
		 * @return	Whether the given array contains the given element
		 */
		public static function contains(a:Array, element:*):Boolean
		{
			return (a.indexOf(element) > -1);
		}
		
		/**
		 * Creates an array containing the ints within the given range, inclusive
		 * 
		 * @param	from	the bottom of the range
		 * @param	to		the top of the range
		 * @return	An array containing the numbers within the given range
		 */
		public static function range(from:int, to:int):Array
		{
			if (to < from)
			{
				var temp:int = from;
				from = to;
				to = temp;
			}
			var a:Array = new Array();
			for (var i:int = from; i <= to; i++)
				a.push(i);
			return a;
		}
		
		
		/**
		 * Removes an element from an array
		 * 
		 * @param	a		The array to remove from
		 * @param	element	The element to remove from the given array
		 */
		public static function remove(a:Array, element:*):void
		{
			while (contains(a, element))
			{
				var i:int = a.indexOf(element);
				a.splice(i, 1);
			}
		}
		
		/**
		 * Creates a clone of an array
		 * 
		 * @param	a	The array to clone
		 * @return	A clone of the array
		 */
		public static function clone(a:Array):Array
		{
			return a.slice();
		}
		
		
		/**
		 * Returns an element chosen at random from an array
		 * 
		 * @param	a	The array to pick from
		 * @return	An element chosen at random from the array
		 */
		public static function pickOne(a:Array):*
		{
			return shuffle(clone(a)).pop();
		}
		
		
		/**
		 * Returns the average of an array of numbers
		 * 
		 * @param	a	The array to calculate the average of
		 * @return	The average of all the elements in the array
		 */
		public static function average(a:Array):Number
		{
			var total:Number = 0;
			for each(var n:Number in a)
			{
				total += n;
			}
			return total / a.length;
		}
	}
}