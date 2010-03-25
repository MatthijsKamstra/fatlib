package org.fatlib.utils
{
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;

	/**
	 * Provides net related helper methods
	 */
	public class NetUtils 
	{
		
		/**
		 * Gets the file extension of a filename
		 * 
		 * @param	filename	The filename to get the extension of
		 * @return	The extension of the filename
		 */
		public static function getExtension(filename:String):String
		{
			var a:Array = filename.split('/');
			var b:Array = (a.pop()).split('.');
			
			if (b.length < 2)
				return '';
				
			var ext:String = b.pop() as String;
			return ext.toLowerCase();
		}
		
		/**
		 * Gets the flashvars loaded into a document 
		 * 
		 * @param	document	The document root of a flash movie
		 * @return	The flashvars object loaded into the document root
		 */
		public static function getFlashVars(document:DisplayObject):Object
		{
			return LoaderInfo(document.root.loaderInfo).parameters;
		}
		
	}
	
}
