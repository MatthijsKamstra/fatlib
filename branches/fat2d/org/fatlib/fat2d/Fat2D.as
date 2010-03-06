package org.fatlib.fat2d 
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.fatlib.game.GameComponent;
	import org.fatlib.interfaces.IBlittable;
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.interfaces.IRenderable;

	public class Fat2D extends Sprite2D implements IDisplayable
	{
//		private var _canvas0:Canvas;
	//	private var _canvas1:Canvas;
		private var _activeCanvas:Canvas;
		private var _display:DisplayObjectContainer;
				
		public function Fat2D(width:int = 400, height:int = 400, fill:int = 0x333333) 
		{
			
			super();
	//		_canvas0 = new Canvas(width, height, fill);
		//	_canvas1 = new Canvas(width, height, fill);
			_activeCanvas =  new Canvas(width, height, fill);//_canvas0;
			
			_display = new Sprite();
			//_display.addChild(_canvas0.display);
			_display.addChild(_activeCanvas.display);
		//	_display.addChild(_canvas1.display);
		}
		
		public function get display():DisplayObjectContainer { return _display; }
		
		override protected function handleRender(params:* = null):void 
		{
			_activeCanvas.clear();
			/*
			if (_activeCanvas == _canvas0)
			{
				_activeCanvas = _canvas1;
				_canvas1.display.visible = true;
				_canvas0.display.visible = false;
			} else {
				_activeCanvas = _canvas0;
				_canvas0.display.visible = true;
				_canvas1.display.visible = false;
			}
			*/
			//_activeCanvas.render();
		}
		
		override public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			_activeCanvas.blit(source, sourceRect, transform);
			
		}
				
	}

}