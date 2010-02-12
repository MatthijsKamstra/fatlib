package org.fatlib.interfaces 
{
	/**
	 * Objects that implement this interface are iterable
	 */
	public interface IIterable 
	{
		/**
		 * Get an iterator for this object
		 * @return	An iterator for this object
		 */
		function getIterator():IIterator;
	}
	
}