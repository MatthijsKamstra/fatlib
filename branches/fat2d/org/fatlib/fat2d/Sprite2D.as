package org.fatlib.fat2d 
{
	import flash.display.BitmapData;
	import org.fatlib.fat2d.Canvas;
	
	public class Sprite2D extends Object2D
	{
		
		private var _bitmap:BitmapData;
		
		public function Sprite2D() 
		{
			super();
		}
		
		override public function render(canvas:Canvas = null):void 
		{
			if (_bitmap) canvas.blit(_bitmap, x, y);
		}
		
		public function set bitmap(value:BitmapData):void 
		{
			_bitmap = value;
		}
		
	}

}