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
	
	public class Canvas extends Sprite2D implements IDisplayable, IBlittable
	{
		private var _display:Sprite;
		private var _width:int;
		private var _height:int;
		private var _fill:int = 0x333333;
		
		public function Canvas(width:int, height:int, fill:Number = 0xFF333333) 
		{
			super();
			_width = width;
			_height = height;
			_fill = fill;
			bitmap = new BitmapData(_width, _height, true, _fill);
			_display = new Sprite();
			_display.addChild(new Bitmap(bitmap));
		}
		
		public function get display():DisplayObjectContainer
		{
			return _display;
		}
		
		override public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			if (transform.a==1 && transform.b==0 && transform.c==0 && transform.d== 1)
			{
				bitmap.copyPixels(source, sourceRect, new Point(transform.tx, transform.ty));
			} else {
				bitmap.draw(source, transform);
			}
		}
		
	}
}