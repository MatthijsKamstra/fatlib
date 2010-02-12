package org.fatlib.iterators
{
	/**
	 * Iterates over the characters in a string
	 */
	public class CharIterator extends ArrayIterator
	{
		
		/**
		 * Creates a new instance. 
		 * @param	string	The string to iterate over
		 */
		public function CharIterator(string:String) 
		{
			var a:Array = [];
			for (var i:int = 0; i < string.length; i++)
				a.push(string.charAt(i));
			super(a);
		}
		
	}

}