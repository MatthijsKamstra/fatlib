package org.fatlib.external
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import org.fatlib.events.LoadProgressEvent;
	import org.fatlib.interfaces.IAssetBank;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.Log;
	import org.fatlib.utils.ClassUtils;
	/**
	 * ...
	 * @author fritz@fritzsolares.com
	 */
	public class BulkLoaderWrapper extends EventDispatcher implements IAssetBank, IDestroyable
	{
		
		[Event(name="onLoaded", 	type="org.fatlib.events.LoadProgressEvent")]
		[Event(name="onError",	 	type="org.fatlib.events.LoadProgressEvent")]
		[Event(name="onProgress", 	type="org.fatlib.events.LoadProgressEvent")]
		
		private var _bulk:BulkLoader;
		private var _mc:MovieClip;
		
		public function BulkLoaderWrapper(name:String='default') 
		{
			_bulk = new BulkLoader(name);
		//	_bulk.logLevel=BulkLoader.LOG_VERBOSE
			_bulk.addEventListener(BulkProgressEvent.PROGRESS, onBulkProgress)
			_bulk.addEventListener(BulkProgressEvent.COMPLETE, onBulkComplete);
			_mc = new MovieClip();
			
		}
		
		
		
		/* INTERFACE org.fatlib.interfaces.IDestroyable */
		
		public function destroy():void
		{
			_bulk.removeEventListener(BulkProgressEvent.PROGRESS, onBulkProgress)
			_bulk.removeEventListener(BulkProgressEvent.COMPLETE, onBulkComplete);
			_bulk.removeAll();
			_mc.removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onBulkComplete(e:BulkProgressEvent):void 
		{
			_mc.removeEventListener(Event.ENTER_FRAME, onFrame);
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.LOADED));
		}
		
		private function onFrame(e:Event):void 
		{
			var fraction:Number = _bulk.weightPercent;	// bulkloader has a bug - the returned value is actually in [0,1]
			if (isNaN(fraction)) fraction = 0;
			dispatchEvent(new LoadProgressEvent(LoadProgressEvent.PROGRESS, fraction));
		}
		
		private function onBulkProgress(e:BulkProgressEvent):void 
		{
			//dispatchEvent(new LoadProgressEvent(LoadProgressEvent.PROGRESS, e.ratioLoaded));
		}
		
		/* INTERFACE org.fatlib.interfaces.IAssetBank */
		
		public function add(url:String, id:String = null, params:Object=null):void
		{
			if (!params) params = { };
			if (!id) id = url;
			if (!params[id]) params['id'] = id;
			_bulk.add(url, params);
		}
		
		public function startLoading():void
		{
			_bulk.start();
			_mc.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function getContent(id:String):*
		{
			return _bulk.getContent(id);
		}
		
		public function getBitmap(id:String):Bitmap
		{
			return _bulk.getBitmap(id);
		}
		
		public function getBitmapData(id:String):BitmapData
		{
			return _bulk.getBitmapData(id);
		}
		
		public function getText(id:String):String
		{
			return _bulk.getText(id);
		}
		
		public function getSound(id:String):Sound
		{
			return _bulk.getSound(id);
		}
		
		public function getXML(id:String):XML
		{
			return _bulk.getXML(id);
		}
		
		public function getMovieClip(id:String):MovieClip
		{
			return _bulk.getMovieClip(id);
		}
		
		public function instantiateSymbol(id:String, linkage:String):*
		{
			var swf:MovieClip = getMovieClip(id);
			return ClassUtils.instantiateSymbol(swf, linkage);
		}
		
		public function instantiateMovieClip(id:String, linkage:String):MovieClip
		{
			return instantiateSymbol(id, linkage) as MovieClip;
		}
		
		
		
		
	}

}