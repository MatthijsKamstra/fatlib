package org.fatlib.game
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.fatlib.game.Canvas;
	import org.fatlib.game.Entity;
	import org.fatlib.game.GameComponent;
	import org.fatlib.interfaces.IBlittable;
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.interfaces.IRenderable;
	import org.fatlib.utils.Delay;
	import org.fatlib.utils.DisplayUtils;

	public class DoubleBufferCanvas extends Canvas
	{
		private var _writeBitmap:BitmapData;
		private var _bitmap0:BitmapData;
		private var _bitmap1:BitmapData;
		
		public function DoubleBufferCanvas(width:int = 400, height:int = 400, fillColor:uint = 0x333333) 
		{
			super(width, height, fillColor);
			_bitmap0 = new BitmapData(width, height, false,  fillColor);
			_bitmap1 = new BitmapData(width, height, false, fillColor );
			_writeBitmap =  _bitmap0;
		}
		
		override protected function handleRender(params:* = null):void 
		{
			bitmap.copyPixels(_writeBitmap, _writeBitmap.rect, new Point(0, 0));

			if (_writeBitmap == _bitmap0)
			{
				_writeBitmap = _bitmap1;
				_writeBitmap.fillRect(_writeBitmap.rect, fillColor);
			} else {
				_writeBitmap = _bitmap0;
				_writeBitmap.fillRect(_writeBitmap.rect, fillColor);
			}

			
		//	trace('writeCanvas = ' + _writeCanvas.name);
		//	_canvas0.display.visible ? trace('visible: 0') : trace('visible: 1');
		//	trace('filling ' + _writeCanvas.name);
		}
		
		override public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			transform.scale(entity.scale, entity.scale);
			transform.translate( width / 2 - entity.scale * entity.x, height / 2 - entity.scale * entity.y);
			if (transform.tx<0 || transform.tx>width || transform.ty<0 || transform.ty>height)return;
			DisplayUtils.blit(source, _writeBitmap, sourceRect, transform);
		}
		
	
		/* INTERFACE org.fatlib.interfaces.IBlittable */
		
		override public function fill(color:uint):void
		{
			_writeBitmap.fillRect(_writeBitmap.rect, color);
		}
		
		
		
				
	}

}