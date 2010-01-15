package org.fatlib.interfaces
{	
	/**
	 * Objects that implement this interface can be destroyed
	 */
	public interface IDestroyable
	{
		/**
		 * Destroys the object when it is no longer needed.
		 * Objects that implement this method should remove all references to themseleves, 
		 * eg. by removing event listeners
		 */
		function destroy():void;
	}
	
}