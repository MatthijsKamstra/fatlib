package org.fatlib.interfaces 
{
	
	/**
	 * Objects that implement this interface can be cloned
	 */
	public interface ICloneable 
	{
		/**
		 * Clone the object
		 * 
		 * @return	A clone of the object
		 */
		function clone():ICloneable;
	}
	
}