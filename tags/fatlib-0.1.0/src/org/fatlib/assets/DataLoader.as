package org.fatlib.assets 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	internal class DataLoader extends ItemLoader
	{
		private var _loader:URLLoader;
		
		public function DataLoader(id:String) 
		{
			super(id);
		}
		
		override public function load(url:String):void 
		{
			super.load(url);
			_loader = new URLLoader();
		    _loader.addEventListener(Event.COMPLETE, onLoaded);
		    _loader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
		    _loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			_loader.load(new URLRequest(url));
		}
		
		private function onLoadError(e:IOErrorEvent):void 
		{
			handleError(e.text);
		}
		
		private function onLoaded(e:Event):void 
		{
			handleLoaded();
		}
		
		private function onLoadProgress(e:ProgressEvent):void
		{
			handleLoadProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		override public function getContent():* 
		{
			return _loader.data;
		}
		
		override public function destroy():void 
		{
			_loader.removeEventListener(Event.COMPLETE, onLoaded);
			_loader.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			_loader = null;
		}
	}
	
}