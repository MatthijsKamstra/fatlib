package org.fatlib.app 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.text.TextField;
	import org.fatlib.assets.LoadStatus;
	import org.fatlib.events.LoadProgressEvent;
	import org.fatlib.Log;
	
	import org.fatlib.utils.TextLookup;
	import org.fatlib.assets.AssetBank;
	import org.fatlib.display.Button;
	import org.fatlib.display.Graphic;
	import org.fatlib.utils.ArrayUtils;
	import org.fatlib.utils.DisplayUtils;
	import org.fatlib.utils.NetUtils;
	
	/**
	 * Constructs graphical elements defined in layout XML files.
	 * 
	 */
	public class LayoutManager extends EventDispatcher 
	{

		[Event(name="onLoaded", 	type="org.fatlib.events.LoadProgressEvent")]
		[Event(name="onError",	 	type="org.fatlib.events.LoadProgressEvent")]
		[Event(name="onProgress", 	type="org.fatlib.events.LoadProgressEvent")]
		
		/**
		 * An object to load & keep references to the loaded assets
		 */
		private var _assets:AssetBank;
		
		/**
		 * An XML object aggregating all the layout XMLs added to the object
		 */
		private var _aggregatedXML:XML;
		
		/**
		 * Root path from which to load assets
		 */
		private var _assetsRoot:String;
	
		/**
		 * Looks up text from resnames in an XLIFF file
		 */
		private var _textLookup:TextLookup;

		
		/**
		 * Creates a new instance of the object
		 */
		public function LayoutManager() 
		{
			Log.log("[LayoutManager] init");
			_aggregatedXML= new XML('<?xml version="1.0" encoding="utf-8" ?><layouts/>');
		}
		
		///////////// PUBLIC METHODS
		
		/**
		 * Adds a layout XML document
		 * 
		 * @param	layoutXML the XML object to add
		 */
		public function addXML(layoutXML:XML):void
		{
			Log.log('[LayoutManager] adding layout');
			_aggregatedXML.appendChild(layoutXML);
		}
		
		/**
		 * Starts the load process. All files referenced in the layout XMLs will be loaded.
		 */
		public function load():void
		{
			
			var assetList:Array = generateAssetList(_aggregatedXML);
			_assets = new AssetBank();
			
			for each(var src:String in assetList)
			{
				_assets.add(_assetsRoot + src, src);
			}
			_assets.addEventListener(LoadProgressEvent.LOADED, onLoaded, false, 0, true);
			_assets.addEventListener(LoadProgressEvent.PROGRESS, onLoadProgress, false, 0, true);
			Log.log("[LayoutManager] loading " + assetList.length + " items");
			_assets.startLoading();
		}
		
		/**
		 * Checks whether all the items within the element with the given id have been loaded
		 * 
		 * @param	id	The id of the element to check
		 * @return	Whether the items within the specified element have been loaded
		 */
		public function isElementLoaded(id:String):Boolean
		{
			var node:XML = findNode(_aggregatedXML, id);
			if (!node) return false;
			var list:Array = generateAssetList(node);
			var loaded:Boolean = true;
			for each(var url:String in list)
			{
				var s:String = _assets.getLoadStatus(_assetsRoot + url) ;
				if (s == LoadStatus.NOT_REFERENCED || s == LoadStatus.QUEUED) loaded = false;
			}
			return loaded;
		}
		
		/**
		 * Constructs an object described by the element with the given id
		 * 
		 * @param	id The id of the element
		 * @return	An object constructed from the specified element
		 */
		public function getElement(id:String):*
		{
			// find the node with the specified id
			var node:XML = findNode(_aggregatedXML, id);
			if (!node)
			{
				Log.warn("No node named " + id + " in layout XML");
				return null;
			}
				
			return createElement(node);
		}
	
		public function get assetsRoot():String { return _assetsRoot; }
		
		public function set assetsRoot(value:String):void 
		{
			if (value.charAt(value.length) != '/') value += '/';
			_assetsRoot = value;
		}
		
		
		public function set textLookup(value:TextLookup):void 
		{
			_textLookup = value;
		}
				
		//////////////
		
		private function onLoadProgress(e:LoadProgressEvent):void 
		{
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.PROGRESS, e.fractionLoaded));
		}
		
		private function onLoaded(e:LoadProgressEvent):void
		{
			Log.log("[LayoutManager] loaded");
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.LOADED));
		}
		
		private function generateAssetList(xml:XML, list:Array = null):Array
		{
			if (!list) list = [];

			if (xml.@src.length() > 0)
			{
				var src:String = xml.@src;
				if (!ArrayUtils.contains(list, src))
					list = list.concat(src);		
			}
			
			for each(var node:XML in xml.children())
				if (xml.nodeType!='data')
					list = generateAssetList(node, list);
				
			return list;
		}
		
		/////////////////////
		
		protected function createElement(node:XML):*
		{
		
			var nodeName:String = node.name();
			var element:*;

			
			switch(nodeName)
			{
				case 'image':
					element = createImage(node);
					break;
				case 'button':
					element = createImage(node, true);
					break;
				case 'text':
					element = createText(node);
					break;
				case 'block':
					element = createBlock(node);
					break;
				case 'container':
					element = createContainer(node);
					break; 
				case 'swf':
					element = createSWF(node);
					break;
				case 'sound':
					element = createSound(node);
					break;
				case 'data':
					element = node;
					break;
				default:
					Log.warn("[LayoutManager] unsupported node: " +nodeName );
					break
			} 
			
			if (element is Graphic)
			{
				
				if (node.@x.length() > 0)
					element.x  = parseFloat(node.@x);
					
				if (node.@y.length() > 0)
					element.y = parseFloat(node.@y);

				if (node.@id.length() > 0)
					element.name = node.@id;
				
				if (node.@alpha.length() > 0)
					element.alpha = parseFloat(node.@alpha)/100;	
					
				element.visible = (node.@visible != 'false');
			}
			
			return element;
		}
		
		
		protected function findNode(xml:XML, id:String):XML
		{
			var retNode:XML;
			for each(var node:XML in xml.children())
			{
				if (node.@id == id)
				{
					retNode = node;
				} else {
					var n:XML = findNode(node, id);
				}
				if (n) retNode = n;
			}
			return retNode;
		}
		
		///////
		
		private function createContainer(node:XML):Graphic
		{
			var container:Graphic = new Graphic();
			for each(var subnode:XML in node.children())
			{
				var element:*= createElement(subnode);
				if (element is DisplayObject) container.addChild(element);
			}
			return container;
		}
		
				
		protected function createImage(node:XML, isButton:Boolean=false):Graphic
		{
			var src:String = node.@src;
			
			var graphic:Graphic;
			
			if (isButton)
			{
				graphic = new Button();
				
			} else if (node.@checkbox == 'true') {
				var checked:Boolean = (node.@checked == 'true');
				graphic = new CheckBox(checked);				
			} else {
				graphic = new Graphic();
			}
			
			if (node.state.length() > 0)
			{
				for each(var stateXML:XML in node.state)
				{
					var state:String = stateXML.@name;
					src = stateXML.@src;
					var image:DisplayObject = instantiate(src) as DisplayObject;
					
					image.x =  stateXML.@x;
					image.y = stateXML.@y;
					
					graphic.registerState(state, image);
					if (stateXML.@default == 'true') graphic.showState(state);
				}
			} else {
				graphic.registerState(Graphic.DEFAULT, instantiate(src) as DisplayObject);
				graphic.showState(Graphic.DEFAULT);
			}
			
			var w:String = node.@w;
			var h:String = node.@h;
			
			if (w.length > 0)
			{
				if (w.charAt(w.length - 1) == '%')
				{
					graphic.scaleX = parseFloat(w.split('%')[0]) / 100;
				} else {
					graphic.width = parseFloat(w);
				}
			} 
			
			if (h.length > 0)
			{
				if (h.charAt(h.length - 1) == '%')
				{
					graphic.scaleY = parseFloat(h.split('%')[0]) / 100;
				} else {
					graphic.height = parseFloat(h);
				}
			}
			
			
			return graphic;
		}
		
		protected function createBlock(node:XML):Graphic
		{
			
			
			var w:Number;
			var h:Number; 
			var color:int;
			
			if (node.@w.length() == 0)
			{
				Log.log("[LayoutManager] Block width must be specified");
				w = 0;
			} else {
				w = parseFloat(node.@w);
			}
			
			if (node.@h.length() == 0)
			{
				Log.log("[LayoutManager] Block height must be specified");
				h = 0;
			} else {
				h = parseFloat(node.@h);
			}
			
			if (node.@color.length() == 0)
			{
				color = 0xBBBBBB;
			} else {
				color = parseInt(node.@color);
			}
			
			var block:Sprite=DisplayUtils.createRectangle(0, 0, w, h, node.@color);
			if (node.@filled == 'false') block.alpha = 0;
			
			var graphic:Graphic = new Graphic();
			graphic.addChild(block);
			return graphic;
		}
		
		protected function createText(node:XML):Text
		{
			var resname:String = node.@resname;
			if (_textLookup)
			{
				var source:String = _textLookup.find(resname);
			} else {
				source = resname;
			}
			
			if (node.@color)
			{
				var color:int = parseInt(node.@color);
			}
			
			if (node.@size)
			{
				var size:int = parseInt(node.@size);
			}
			
			if (node.@html)
			{
				var html:Boolean = (node.@html == 'true');
			}
			
			var w:Number = node.@w;
			var h:Number = node.@h;
			
			var t:Text = new Text(source, '', size, html, color, w, h);
			if (node.@input == 'true')
			{
				t.isInput = true;
				if (node.@limit)
				{
					t.characterLimit = parseInt(node.@limit);
				}
				
			}
			
			return t;
		}
		
		protected function createSWF(node:XML):MovieClip
		{
			var src:String = node.@src;
			var id:String = node.@id;
			var swf:MovieClip = instantiate(src) as MovieClip;
			return swf;
		}
		
		protected function createSound(node:XML):Sound
		{
			var src:String = node.@src;
			return instantiate(src) as Sound;
		}
		
					
		protected function instantiate(src:String):Object
		{
			var output:Object;
			switch(NetUtils.getExtension(src))
			{
				case 'jpg':
				case 'png':
					output = _assets.getBitmap(src);
					if (output == null) output = new Text('missing graphic: ' + src);
					break;
				case 'swf':
					output= _assets.getMovieClip(src);
					break;
				case 'mp3':
					output = _assets.getSound(src); 
					break;
			}
			return output;
		}
		
		

	}
	
}