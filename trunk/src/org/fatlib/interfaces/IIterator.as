package org.fatlib.interfaces
{

	/**
	 * Objects that implement this object iterate linearly through some data set
	 */
	public interface IIterator 
	{
		/**
		 * Are there any elements left to iterate through?
		 */
		function get hasNext():Boolean;
		
		/**
		 * Get the next element
		 */
		function get next():*;
		
		/**
		 * Get the iterator's current position within the dataset, starting at 0
		 */
		function get position():int
	}
	
}
