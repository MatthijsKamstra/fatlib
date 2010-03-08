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

	public class Fat2D extends Entity implements IDisplayable, IBlittable
	{
		private var _canvas0:Canvas;
		private var _canvas1:Canvas;
		private var _writeCanvas:Canvas;
		private var _display:DisplayObjectContainer;
		private var _fps:Number = 30;
		
		private var _viewX:Number = 0;
		private var _viewY:Number = 0;
				
		private var _fillColor:int;
		private var _width:int = 0;
		private var _height:int = 0;
		
		private var _screen:BitmapData;
		
		public function Fat2D(width:int = 400, height:int = 400, fill:int = 0x333333) 
		{
			
			super();
			_width = width;
			_height = height;
			
			_fillColor = fill + 0xFF000000;
			_canvas0 = new Canvas(_width, _height, _fillColor);
			_canvas1 = new Canvas(_width, _height, _fillColor);
			
			_canvas0.name = '0';
			_canvas1.name = '1';
			
			_writeCanvas =  _canvas0;
				
			_display = new Sprite();
			_screen = new BitmapData(width, height, false, fill)
			_display.addChild(new Bitmap(_screen));
			//_display.addChild(_canvas1.display);
			
			
			world = this;
		}
		
		public function get display():DisplayObjectContainer { return _display; }
		
		
		
		override protected function handleRender(params:* = null):void 
		{
			_screen.copyPixels(_writeCanvas.bitmap, _writeCanvas.bitmap.rect, new Point(0, 0));

			if (_writeCanvas == _canvas0)
			{
				_writeCanvas = _canvas1;
				_canvas1.fill(_fillColor);
				
			} else {
				_writeCanvas = _canvas0;
				_canvas0.fill(_fillColor);
			}

			
		//	trace('writeCanvas = ' + _writeCanvas.name);
		//	_canvas0.display.visible ? trace('visible: 0') : trace('visible: 1');
		//	trace('filling ' + _writeCanvas.name);
		}
		
		public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			transform.scale(scale, scale);
			transform.translate( _width / 2 - scale* x, _height / 2 - scale*y);
			_writeCanvas.blit(source, sourceRect, transform);
		//	trace('blitting to '+_writeCanvas.name);
		}
		
		public function get bitmap():BitmapData
		{
			return _writeCanvas.bitmap;
		}
		
		/* INTERFACE org.fatlib.interfaces.IBlittable */
		
		public function fill(color:uint):void
		{
			_writeCanvas.fill(color);
		}
		
		
		
				
	}

}