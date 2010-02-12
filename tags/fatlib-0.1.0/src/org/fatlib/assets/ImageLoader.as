package org.fatlib.assets 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	internal class ImageLoader extends ItemLoader
	{
		private var _loader:Loader;
		
		public function ImageLoader(id:String) 
		{
			super(id);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}

		override public function load(url:String):void 
		{
			super.load(url);
			_loader.load(new URLRequest(url));
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			handleError(e.text);
		}
				
		private function onProgress(e:ProgressEvent):void 
		{
			handleLoadProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		private function onLoaded(e:Event):void 
		{
			handleLoaded();
		}
		
		override public function getContent():* 
		{
			return _loader.content;
		}
		
		override public function destroy():void 
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader = null;
		}
		
		
	}
	
}