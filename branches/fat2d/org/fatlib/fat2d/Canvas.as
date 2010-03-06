package org.fatlib.fat2d 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.fatlib.interfaces.IBlittable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.game.GameComponent;
	import org.fatlib.utils.ColorUtils;
	
	public class Canvas extends GameComponent implements IDisplayable, IBlittable
	{
		private var _display:Sprite;
		private var _bitmap:BitmapData;
		private var _width:int;
		private var _height:int;
		private var _fill:int = 0x333333;
		
		public function Canvas(width:int, height:int, fill:int = 0x333333) 
		{
			super();
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
		
		public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			
			if (transform.a==1 && transform.b==0 && transform.c==0 && transform.d== 1)
			{
				_bitmap.copyPixels(source, sourceRect, new Point(transform.tx, transform.ty));
			} else {
				_bitmap.draw(source, transform);
			}
			
			_bitmap.setPixel(200, 200, 0x000000);
		}
	
	
		public function clear():void
		{
			_bitmap.fillRect(_bitmap.rect, _fill);
		}
		
		
	}
}