package org.fatlib.game.standard
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.fatlib.game.GameComponent;
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.utils.Delay;
	import org.fatlib.utils.DisplayUtils;

	public class DoubleBufferCanvas extends Canvas
	{
		private var _writeBitmap:BitmapData;
		private var _bitmap0:BitmapData;
		private var _bitmap1:BitmapData;
		
		public function DoubleBufferCanvas(width:int, height:int, fillColor:uint = 0x333333) 
		{
			super(width, height, fillColor);
			_bitmap0 = new BitmapData(width, height, false,  fillColor);
			_bitmap1 = new BitmapData(width, height, false, fillColor );
			_writeBitmap =  _bitmap0;
		}
		
		override public function render(params:* = null):void 
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
		
		
		override public function blit(source:BitmapData, sourceRect:Rectangle = null, transform:Matrix = null):void
		{
		if (sourceRect == null) sourceRect = source.rect;
			if (transform == null) transform = new Matrix();
			transform.scale(camera.transform.scale, camera.transform.scale);
			transform.translate( width / 2 - camera.transform.scale * camera.transform.x, height / 2 - camera.transform.scale * camera.transform.y);
			
			//if (transform.tx<0 || transform.tx>width || transform.ty<0 || transform.ty>height)return;
			DisplayUtils.blit(source, _writeBitmap, sourceRect, transform);
		}
		
	
		/* INTERFACE org.fatlib.interfaces.IBlittable */
		
		override public function fill(color:uint):void
		{
			_writeBitmap.fillRect(_writeBitmap.rect, color);
		}
		
		
		
				
	}

}