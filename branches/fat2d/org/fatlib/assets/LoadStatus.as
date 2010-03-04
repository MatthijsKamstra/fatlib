package org.fatlib.assets 
{
	/**
	 * Defines consts used by AssetBank when being queried for an item's load status
	 */
	public class LoadStatus
	{
		/**
		 * The item has loaded OK
		 */
		public static const LOAD_OK:String = "LOAD_OK";
		
		/**
		 * The item failed to load
		 */
		public static const LOAD_FAIL:String = "LOAD_FAIL";
		
		/**
		 * The item is queued to load
		 */
		public static const QUEUED:String = "QUEUED";
		
		/**
		 * The item hasn't ever been queued 
		 */
		public static const NOT_REFERENCED:String = "NOT_REFERENCED";
	}

}