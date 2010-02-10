package org.fatlib.assets 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import org.fatlib.Log;
	import org.fatlib.utils.ArrayUtils;
	
	import org.fatlib.events.CustomEvent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.utils.ClassUtils;
	import org.fatlib.utils.NetUtils;
	
	public class AssetBank extends EventDispatcher implements IDestroyable
	{
		public static const ALL_ASSETS_LOADED:String = 'onAllAssetsLoaded';
		public static const LOAD_PROGRESS:String = 'onLoadProgress';
		public static const ASSET_LOADED:String = 'onAssetLoaded';
		public static const LOAD_ERROR:String = 'onLoadError';
		
		private var _assets:Dictionary;
		private var _toLoad:Array;
		private var _loadedURLs:Array;
		private var _failedURLs:Array;
		private var _itemLoader:ItemLoader;
		
		public function AssetBank() 
		{
			_assets = new Dictionary();
			_toLoad = [];
			_loadedURLs = [];
			_failedURLs = [];
		}
		
		public function add(url:String, id:String=null):void
		{
			if (id == null) id = url;
			Log.log("[AssetBank] add "+url+" as "+id);
			
			for each(var o:Object in _toLoad)
				if (o['id']==id && o['url'] == url)
					return;
					
			_toLoad.push( { id:id, url:url} );
		}
		
		public function startLoading():void
		{
			Log.log("[AssetBank] loading "+_toLoad.length+' items');
			loadNext();
		}
		
		public function getContent(id:String):*
		{
			return _assets[id];
		}
		
		public function getBitmapData(id:String):BitmapData
		{
			return (getContent(id) as Bitmap).bitmapData;
		}
				
		public function getText(id:String):String
		{
			return getContent(id) as String;
		}
		
		public function getSound(id:String):Sound
		{
			return getContent(id) as Sound;
		}
		
		public function getXML(id:String):XML
		{
			var x:XML;
			try
			{
				x = new XML(getText(id))
			} catch (r:Error) {
				dispatchEvent(new ErrorEvent(LOAD_ERROR, false, false, 'Problem parsing XML with id ' + id+ ': '+r));
			}
							
			return x;
		}
		
		public function getMovieClip(id:String):MovieClip
		{
			return getContent(id) as MovieClip;
		}
		
		public function instantiateSymbol(id:String, linkage:String):*
		{
			return ClassUtils.instantiateSymbol(getMovieClip(id), linkage);
		}
		
		public function instantiateMovieClip(id:String, linkage:String):MovieClip
		{
			return instantiateSymbol(id, linkage) as MovieClip;
		}
		
			
	
		
		public function destroy():void
		{
			// TODO implement
		}
		
		/**
		 * 
		 * @param	id	The id of the asset to check 
		 * @return	a string 
		 */
		public function getLoadStatus(url:String):String
		{
			var s:String = LoadStatus.NOT_REFERENCED;
			if (ArrayUtils.contains(_loadedURLs, url)) s = LoadStatus.LOAD_OK;
			if (ArrayUtils.contains(_failedURLs, url)) s = LoadStatus.LOAD_FAIL;
			
			for each(var o:Object in _toLoad)
				if (o['url'] == url)
					s = LoadStatus.QUEUED;
					
			return s;
			
		}
		
		
		//////////// PRIVATE METHODS
		
		
		private function loadNext():void
		{
			if (_toLoad.length == 0)
			{
				assetsAllLoaded();
			} else {
				var asset:Object = _toLoad.shift();
				var url:String = asset.url;
				var id: String = asset.id;
				loadAsset(url, id)
			}
		}
		
		private function assetsAllLoaded():void
		{
			Log.log("[AssetBank] loading complete");
			dispatchEvent(new Event(ALL_ASSETS_LOADED));
		}
		
		private function loadAsset(url:String, id:String):void
		{
			
			var type:String = NetUtils.getExtension(url);
			switch(type)
			{
				case 'jpg':
				case 'png':
				case 'swf':
					_itemLoader = new ImageLoader(id);
					break;
				case 'mp3':
					_itemLoader = new SoundLoader(id);
					break;
				default:
					_itemLoader = new DataLoader(id);
					break;
					//throw new Error('Loader not implemented for file extension ' + type);
			}
			
			_itemLoader.addEventListener(ItemLoader.LOADED, onAssetLoaded);
			_itemLoader.addEventListener(ItemLoader.LOAD_PROGRESS, onAssetLoadProgress);
			_itemLoader.addEventListener(ItemLoader.LOAD_ERROR, onAssetLoadError);
			_itemLoader.load(url);
		}
		
		private function onAssetLoadError(e:Event):void 
		{
			Log.warn("[AssetBank] load error " + _itemLoader.url );
			_itemLoader.destroy();
			
			_failedURLs.push(_itemLoader.url);
			
			_itemLoader.removeEventListener(ItemLoader.LOADED, onAssetLoaded);
			_itemLoader.removeEventListener(ItemLoader.LOAD_PROGRESS, onAssetLoadProgress);
			_itemLoader.removeEventListener(ItemLoader.LOAD_ERROR, onAssetLoadError);
			_itemLoader = null;
			loadNext();
		}
		
		private function onAssetLoaded(e:Event):void 
		{
			var loader:ItemLoader = (e.target as ItemLoader);
			Log.log("[AssetBank] loaded " +_itemLoader.id );
			
			_assets[loader.id] = _itemLoader.getContent();
			_loadedURLs.push(_itemLoader.url);
			
			_itemLoader.removeEventListener(ItemLoader.LOADED, onAssetLoaded);
			_itemLoader.removeEventListener(ItemLoader.LOAD_PROGRESS, onAssetLoadProgress);
			_itemLoader.removeEventListener(ItemLoader.LOAD_ERROR, onAssetLoadError);
			_itemLoader = null;
			loadNext();
		}
		
		//TODO weight
		private function onAssetLoadProgress(e:CustomEvent):void 
		{
			//var progress:Number = e.data as Number;
			
			var fraction:Number = (_loadedURLs.length + _failedURLs.length) / (_failedURLs.length + _loadedURLs.length + _toLoad.length);
			var progress:Object = {fraction:fraction, percentage:fraction * 100};
			
			dispatchEvent(new CustomEvent(LOAD_PROGRESS, progress));
		}
		
		
	}
	
	
	
}