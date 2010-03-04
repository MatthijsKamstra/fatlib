package org.fatlib.fat2d 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;

	public class Fat2D implements IDisplayable, IDestroyable
	{
		private var _canvas0:Canvas;
		private var _canvas1:Canvas;
		private var _activeCanvas:int = 0;
		private var _objects:Array;
		private var _display:DisplayObjectContainer;
				
		public function Fat2D(width:int = 400, height:int = 400, fill:int = 0x333333) 
		{
			_canvas0 = new Canvas(width, height, fill);
			_canvas1 = new Canvas(width, height, fill);
			_objects = [];
			
			_display = new Sprite();
			_display.addChild(_canvas0.display);
			_display.addChild(_canvas1.display);
		}
		
		public function get display():DisplayObjectContainer
		{
			return _display;
			
		}
		
		public function addObject(o:Object2D):void
		{
			_objects.push(o);
		}
		
		public function removeObject(name:String):void
		{
		}
		
		public function getObject(name:String):Object2D
		{
			return null;
		}
		
		public function update(timeStep:Number = 0):void
		{
			for each(var o:Object2D in _objects)
			{
				o.update(timeStep);
			}
		}
		
		public function render(canvas:Canvas = null):void
		{
			if (_activeCanvas == 0)
			{
				var writeCanvas:Canvas = _canvas1;
			} else {
				writeCanvas = _canvas0;
			}
			
			writeCanvas.render();
			for each(var o:Object2D in _objects)
			{
				o.render(writeCanvas);
			}
			
			_canvas0.display.visible = _activeCanvas == 0;
			_canvas1.display.visible = _activeCanvas == 1;
			
			_activeCanvas = 1 - _activeCanvas;
			
		}
		
		/* INTERFACE org.fatlib.interfaces.IDestroyable */
		
		public function destroy():void
		{
			
		}
		
	}

}