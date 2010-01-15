package org.fatlib.assets 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	internal class SoundLoader extends ItemLoader
	{
		private var _sound:Sound;
		
		public function SoundLoader(id:String) 
		{
			super(id);
			_sound = new Sound();
			_sound.addEventListener(Event.COMPLETE, onLoaded);
            _sound.addEventListener(IOErrorEvent.IO_ERROR, onError);
            _sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		override public function load(url:String):void 
		{
			super.load(url);
			_sound.load(new URLRequest(url));
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
			return _sound;
		}
		
		override public function destroy():void 
		{
			_sound.removeEventListener(Event.COMPLETE, onLoaded);
            _sound.removeEventListener(IOErrorEvent.IO_ERROR, onError);
            _sound.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_sound = null;
		}
		
		
	}
	
}