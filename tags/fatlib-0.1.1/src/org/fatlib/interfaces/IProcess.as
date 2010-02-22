package org.fatlib.interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Objects that implement this interface are processes
	 */
	public interface IProcess
	{
		/**
		 * Starts
		 * 
		 * 
		 * the process
		 */
		function execute():void;
		
		/**
		 * Terminate the process
		 */
		function terminate():void
		
		
	}
}