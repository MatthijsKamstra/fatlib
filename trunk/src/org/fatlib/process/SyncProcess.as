package org.fatlib.process
{
	import org.fatlib.interfaces.IProcess;
	
	/**
	 * A synchronous process. Completes instantaneously.
	 */
	public class SyncProcess implements IProcess
	{
		
		/**
		 * Creates a new instance
		 */
		public function SyncProcess() 
		{
		}
			
		/**
		 * Starts the process.
		 */
		public function execute():void
		{
		}
		
		public function terminate():void
		{
		}
		
	}
}