﻿package org.fatlib
{
	
	import flash.external.ExternalInterface;
	
	/**
	 * A logging class
	 * 
	 * Uses ExternalInterface to send to FireBug
	 * 
	 */
	public class Log 
	{
		
		public static const LOG:int = 1;
		public static const DEBUG:int = 2;
		public static const WARN:int = 3;
		public static const ERROR:int = 4;
		
		public static var LOG_LEVEL:int = LOG;
		
		public static var ALLOW_LOGGING:Boolean = true;
		
		public static function log(item:*):void 
		{
			if (LOG_LEVEL <= LOG)
				send("log", item);
		}
	
		public static function debug(item:*):void 
		{
			if (LOG_LEVEL <= DEBUG)
				send("debug", item);
		}
		
		public static function warn(item:*):void 
		{
			if (LOG_LEVEL <= WARN)
				send("warn", item);
		}
	
		public static function info(item:*):void 
		{
			send("info", item);
		}
		
		public static function error(item:*):void 
		{
			send("error", item);
		}
		
		private static function send(level:String, item:*):void 
		{
			if (!ALLOW_LOGGING) return;
			
			// trace to flash 
			trace(level + ': ' + item);
			try
			{
				// send to FireBug
				ExternalInterface.call("console." + level, item);
			} catch (er:Error)
			{
		
			}
		}
	}
}
