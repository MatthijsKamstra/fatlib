﻿package org.fatlib.utils
{
	import org.fatlib.Log;
	
	/**
	 * Provides access to config data stored in a config XML something like this:
	 * 
	 * 
	 * <config>
	 * 		<property name="song_url" value="song.mp3" />
	 * 
	 *		<list name="fruit">
	 * 			<property value="apple" />
	 * 			<property value="banana" />
	 * 			<property value="cherry" />
	 * 		</config>
	 * </hash>
	 * 
	 * @usage
	 * 
	 * var config:Config = new Config(configXML);
	 * 
	 * trace(config.getProperty('song_url');
	 * //	song.mp3
	 * 
	 * trace(config.getList('fruit'));
	 * // 	apple,banana,cherry
	 * 
	 * 
	 */
	public class Config
	{
		
		private var _props:Object;
		private var _lists:Object;
		
		//	private var _hashes:Object;
		
		/**
		 * Creates a new instance
		 */
		public function Config()
		{
		}
		
		/**
		 * initializes the object
		 * 
		 * @param	configXML	The XML object containing data to be accessed
		 */
		public function init(configXML:XML):void
		{
			Log.log("[Config] init");
			
			_props = { };
		//	_hashes = { };
			_lists = { };
			
			for each(var node:XML in configXML.property)
			{
				var name:String = node.@name;
				var value:String = node.@value;
				_props[name] = value;
			}
			/*
			for each(node in configXML.hash)
			{
				name = node.@name;
				_hashes[name] = node;
			}
			*/
			
			for each(node in configXML.list)
			{
				name = node.@name;
				var list:Array = [];
				for each(var item:XML in node.item)
				{
					list.push(item.@value);
				}
				_lists[name] = list;
			}
		}
		
		/**
		 * gets the string value of the property with the given name
		 * 
		 * @param	name	The name of the property to be returned
		 * @return	The string value of the property with the given name
		 */
		public function getProp(name:String):String
		{
			//if (!_props[name]) Log.warn('[Config] no property named ' + name);
			return _props[name];
		}
		
		/**
		 * Gets the boolean value of the property with the given name
		 * 
		 * @param	name	The name of the property to be returned
		 * @return	The boolean value of the property with the given name
		 */
		public function getBoolean(name:String):Boolean
		{
			return getProp(name) == 'true';
		}
		
		
		/**
		 * Gets the int value of the property with the given name
		 * 
		 * @param	name	The name of the property to be returned
		 * @return	The int value of the property with the given name
		 */
		public function getInt(name:String):int
		{
			return parseInt(getProp(name));
		}
		
		
		/**
		 * Gets the float value of the property with the given name
		 * 
		 * @param	name	The name of the property to be returned
		 * @return	The float value of the property with the given name
		 */
		public function getFloat(name:String):Number
		{
			return parseFloat(getProp(name));
		}
		
		
		/**
		 * Gets list with the given name, as an array of values
		 * 
		 * @param	name	The name of the list to be returned
		 * @return	An array of values in the list 
		 */
		public function getList(name:String):Array
		{
			return _lists[name];
		}
		
		
		/*
		
		public function getConfig(name:String):Config
		{
			return new Config(_hashes[name]);
		}
	*/
		
	}
	
}