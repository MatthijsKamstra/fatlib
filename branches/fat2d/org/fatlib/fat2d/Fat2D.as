package org.fatlib.fat2d 
{
	import flash.display.DisplayObjectContainer;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;

	public class Fat2D implements IDisplayable, IDestroyable, IEntity
	{
		private var _canvas:Canvas;
		private var _objects:Array;
		
		public function Fat2D(width:int = 400, height:int = 400, fill:int = 0x333333) 
		{
			_canvas = new Canvas(width, height, fill);
			_objects = [];
		}
		
		public function get display():DisplayObjectContainer
		{
			return _canvas.display;
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
			_canvas.render();
			for each(var o:Object2D in _objects)
			{
				o.render(_canvas);
			}
		}
		
		/* INTERFACE org.fatlib.interfaces.IDestroyable */
		
		public function destroy():void
		{
			
		}
		
	}

}