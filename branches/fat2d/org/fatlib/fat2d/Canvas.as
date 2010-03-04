package org.fatlib.fat2d 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.fatlib.fat2d.Canvas;
	import org.fatlib.interfaces.IDisplayable;

	public class Canvas implements IDisplayable, IEntity
	{
		
		private var _display:Sprite;
		private var _bitmap:BitmapData;
		private var _width:int;
		private var _height:int;
		private var _fill:int = 0x333333;
		
		public function Canvas(width:int, height:int, fill:int = 0x333333) 
		{
			_width = width;
			_height = height;
			_fill = fill;
			_bitmap = new BitmapData(_width, _height, false, _fill);
			_display = new Sprite();
			_display.addChild(new Bitmap(_bitmap));
		}
		
		public function get display():DisplayObjectContainer
		{
			return _display;
		}
		
		public function blit(source:BitmapData, x:int, y:int):void
		{
			_bitmap.copyPixels(source, source.rect, new Point(x, y));
		}
		
		public function update(timeStep:Number = 0):void
		{
		}
		
		public function render(canvas:Canvas = null):void
		{
			_bitmap.fillRect(_bitmap.rect, _fill);
		}
		
	}

}