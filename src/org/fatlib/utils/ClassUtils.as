package org.fatlib.utils
{
	
	import flash.display.MovieClip;
	import flash.utils.*;

	
	/**
	 * Provides helper methods for dealing with class introspection or
	 * object instantiation
	 * 
	 */
	public class ClassUtils
	{
		
		/**
		 * Get the name of the class that the given object is an instance of
		 * 
		 * @param	object	The object to find the class name of
		 * @return	The name of the class that the given object is an instance of
		 */
		public static function getClassName(object:Object):String
		{
			return getFullClassName(object).split('::')[1]
		}
				
		/**
		 * Instantiates a symbol in the library of a SWF
		 * 
		 * @param	swf			The SWF whose library contains the symbol to instantiate
		 * @param	linkageID	The linkage id of the symbol in the library
		 * @return	An object instantiated from the symbol in the library
		 */
		public static function instantiateSymbol(swf:MovieClip, linkageID:String='Content'):Object
		{
			var classReference:Class = swf.loaderInfo.applicationDomain.getDefinition(linkageID) as Class;
			var sup:String = getSuperClassName(classReference);
			var inst:Object;
			switch (sup)
			{
				case 'BitmapDataObject':
					inst = new classReference(0, 0);
					break;
				default:
					inst = new classReference();
					break;
			}
			return inst;
		}

		
		////////
		
		public static function getFullClassName(object:Object):String
		{
			return getQualifiedClassName(object)//.split('::')[1]
		}
		
		private static function getSuperClassName(object:Object):String	// just works for instantiateSymbol stuff
		{
			var full:String = describeType(object).factory.extendsClass.@type;
			return full.split('::')[1];
		}

		

		
		
	}
	
}
