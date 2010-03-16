package org.fatlib.game.interfaces 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public interface IBlittable 
	{
		function blit(source:BitmapData, sourceRect:Rectangle = null, transform:Matrix = null):void;
		function fill(color:uint):void;
		function get width():int;
		function get height():int;
		function get bitmap():BitmapData;
	}
	
}