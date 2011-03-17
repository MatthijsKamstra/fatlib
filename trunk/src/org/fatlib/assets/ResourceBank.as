package org.fatlib.assets
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import org.fatlib.events.LoadProgressEvent;
	import org.fatlib.interfaces.IAssetBank;
	
	/**
	 * For accessing embedded SWFs
	 */
	public class ResourceBank extends EventDispatcher 
	{
		[Event(name="onLoaded", 	type="org.fatlib.events.LoadProgressEvent")]
		
		private var _resources:Array;
		private var _numLoaded:int;
		private var _numTotal:int;
		
		public function ResourceBank() 
		{
			_resources = [];
		}
		
		public function addResource(id:String, swf:Class):void
		{
			_resources[id] = new Resource(swf);
		}
			
		public function startLoading():void
		{
			_numLoaded = 0;
			_numTotal = 0;
			var r:Resource;
			for each(r in _resources)
				if (!r.loaded)
					_numTotal++;
			for each(r in _resources)
				if (!r.loaded)
					r.load(handleResourceLoaded);
		}
		
		private function handleResourceLoaded():void
		{
			_numLoaded++;
			if (_numLoaded == _numTotal)
			{
				dispatchEvent(new LoadProgressEvent(LoadProgressEvent.LOADED));
			}
		}

		private function getResource(id:String):Resource
		{
			var r:Resource = _resources[id];
			if (!r) throw new Error('no such resource as ' + id);
			if (!r.loaded) throw new Error('resource ' + id + ' not loaded');
			return r;
		}
		
		public function instantiateBitmapData(id:String, linkage:String):BitmapData
		{
			var c:Class = getResource(id).getDef(linkage);
			return new c(0, 0) as BitmapData;
		}
		
		public function instantiateSound(id:String, linkage:String):Sound
		{
			var c:Class = getResource(id).getDef(linkage);
			return new c() as Sound;
		}
		
		public function instantiateMovieClip(id:String, linkage:String):MovieClip
		{
			var c:Class = getResource(id).getDef(linkage);
			return new c() as MovieClip;
		}

		
	}

}


import flash.display.Loader;
import flash.events.Event;
import org.fatlib.process.Callback;
internal class Resource
{
	private var _done:Callback;
	private var _swf:Class;
	
	public var loaded:Boolean = false;
	public var loader:Loader;
	
	public function Resource(swf:Class)
	{
		_swf = swf;
	}
	
	public function load(callback:Function):void
	{
		_done = new Callback(callback);
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
		loader.loadBytes(new _swf());
	}
	
	private function onInit(e:Event):void 
	{
		loaded = true;
		loader.contentLoaderInfo.removeEventListener(Event.INIT, onInit);
		_done.execute();
	}
	
	public function getDef(linkage:String):Class
	{
		return loader.contentLoaderInfo.applicationDomain.getDefinition(linkage) as Class;
	}
}