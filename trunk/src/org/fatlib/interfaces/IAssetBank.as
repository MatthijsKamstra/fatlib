package org.fatlib.interfaces 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	
	public interface IAssetBank extends IEventDispatcher, IDestroyable
	{
		function add(url:String, id:String = null, params:Object = null):void;
		function startLoading():void;
		function getContent(id:String):*;
		function getBitmap(id:String):Bitmap;
		function getBitmapData(id:String):BitmapData;
		function getText(id:String):String;
		function getSound(id:String):Sound;
		function getXML(id:String):XML;
		function getMovieClip(id:String):MovieClip;;
		function instantiateSymbol(id:String, linkage:String):*;
		function instantiateMovieClip(id:String, linkage:String):MovieClip;
	}
	
}