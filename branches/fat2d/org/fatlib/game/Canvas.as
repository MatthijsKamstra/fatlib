package org.fatlib.game 
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
		private var _width:int;
		private var _height:int;
		private var _fill:int = 0x333333;
		private var _rect:Rectangle;
		private var _bitmap:BitmapData;
		
		public function Canvas(width:int, height:int, fill:Number = 0xFF333333) 
		{
			super();
			_width = width;
			_height = height;
			_fill = fill;
			_bitmap = new BitmapData(_width, _height, true, _fill);
			_display = new Sprite();
			_display.addChild(new Bitmap(_bitmap));
			_rect = new Rectangle(0, 0, _width, _height);
		}
		
		public function get display():DisplayObjectContainer
		{
			return _display;
		}
		
		public function get bitmap():BitmapData { return _bitmap; }
		
		public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			if (transform.tx<0 || transform.tx>_width || transform.ty<0 || transform.ty>_height)return;
			
			if (transform.a==1 && transform.b==0 && transform.c==0 && transform.d== 1)
			{
				_bitmap.copyPixels(source, sourceRect, new Point(int(transform.tx), int(transform.ty)));
			} else {
				_bitmap.draw(source, transform);
			}
		}
		
		/* INTERFACE org.fatlib.interfaces.IBlittable */
		
		public function fill(color:uint):void
		{
			_bitmap.fillRect(_bitmap.rect, _fill);
		}
		
	}
}