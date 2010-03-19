package org.fatlib.app
{
	import org.fatlib.interfaces.IDestroyable;
	/**
	 * Given an XLIFF XML file, looks up text entried keyed by resname
	 */
	public class TextLookup implements IDestroyable
	{
		private var _units:Object;
		
		/**
		 * Creates a new instance
		 */
		public function TextLookup()
		{
		}
		
		/**
		 * Initializes the object
		 * 
		 * @param	xliff	An XML object of the XLIFF to reference
		 */
		public function init(xliff:XML):void
		{
			_units = { };
			for each(var unitXML:XML in xliff.file.body['trans-unit'])
			{
				var resname:String = unitXML.@resname;
				var source:XMLList = unitXML.source;
				var s:XML = source[0];
				XML.prettyIndent = 0;
				var htmlFragment:String  =s.toString()//.toXMLString();
				htmlFragment = htmlFragment.replace(/\n/, '');
				htmlFragment = htmlFragment.replace(/<source>/, '');
				htmlFragment = htmlFragment.replace(/<\/source>/, '');
				
				var remixed:String = '';
				
				for (var i:int = 0; i < htmlFragment.length; i++)
				{
					//trace(htmlFragment.charAt(i), htmlFragment.charCodeAt(i));
					
					var char:int = htmlFragment.charCodeAt(i)
					switch(char)
					{
						case 10:
							break;
						default:
							remixed += String.fromCharCode(char);
							break;
					}
				}
				
				// this produces something like <source>Content here</source>
				
				// should remove <source> and </source> but TextField.htmlText seems to render it OK as is.
								
				_units[resname] = remixed//htmlFragment;
			}
		}
		
		/**
		 * Finds the text element with the given resname in the XLIFF object.
		 * If no resname is found, returns the original resname as text
		 * 
		 * @param	resname	The resname to look for.
		 * @return	The text content in the XLIFF object with the specified resname
		 */
		public function find(resname:String):String
		{
			var source:String = _units[resname];
			if (source == null)
			{
				source = '!!! '+resname;
			} 
			return source;
		}
		
		/* INTERFACE org.fatlib.interfaces.IDestroyable */
		
		public function destroy():void
		{
			
		}
		
		
	}

}