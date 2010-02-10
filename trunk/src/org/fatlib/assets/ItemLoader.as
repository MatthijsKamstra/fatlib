package org.fatlib.assets 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.Log;
	
	internal class ItemLoader extends EventDispatcher implements IDestroyable
	{
		private var _id:String;
		private var _url:String;
		
		public static const LOADED:String = 'onLoaded';
		public static const LOAD_PROGRESS:String = 'onLoadProgress';
		public static const LOAD_ERROR:String = 'onLoadError';
		
		public function ItemLoader(id:String)
		{
			_id = id;
		}
		
		public function load(url:String):void
		{
			_url = url;
		}
		
		protected function handleLoadProgress(fractionLoaded:Number):void
		{
			dispatchEvent(new LoadProgressEvent(LOAD_PROGRESS, fractionLoaded));
		}
		
		protected function handleLoaded():void
		{
			dispatchEvent(new Event(LOADED));
		}
		
		protected function handleError(text:String):void
		{
			Log.log("[ItemLoader] Error: " + text);
			dispatchEvent(new Event(LOAD_ERROR));
		}
		
		public function getContent():*
		{
		}
		
		
		public function destroy():void
		{
			
		}
		
		public function get id():String { return _id; }
		public function get url():String { return _url; }
	}
}