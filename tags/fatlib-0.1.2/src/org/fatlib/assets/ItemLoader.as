package org.fatlib.assets 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.fatlib.events.LoadProgressEvent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.Log;
	
	internal class ItemLoader extends EventDispatcher implements IDestroyable
	{
		
		[Event(name="onLoaded", 	type="org.fatlib.events.LoadProgressEvent")]
		[Event(name="onError",	 	type="org.fatlib.events.LoadProgressEvent")]
		[Event(name="onProgress", 	type="org.fatlib.events.LoadProgressEvent")]
		
		private var _id:String;
		private var _url:String;
		
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
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.PROGRESS, fractionLoaded));
		}
		
		protected function handleLoaded():void
		{
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.LOADED));
		}
		
		protected function handleError(text:String):void
		{
			Log.log("[ItemLoader] Error: " + text);
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.ERROR));
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