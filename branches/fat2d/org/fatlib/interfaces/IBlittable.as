package org.fatlib.interfaces 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public interface IBlittable 
	{
		function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void;
		function fill(color:uint):void;
	}
	
}