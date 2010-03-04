package org.fatlib.fat2d 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import org.fatlib.fat2d.Canvas;
	
	public class Sprite2D extends Object2D
	{
		
		private var _bitmap:BitmapData;
		private var _transform:Matrix;
		
		public function Sprite2D() 
		{
			super();
			_transform = new Matrix();
		}
		
		override public function render(canvas:Canvas = null):void 
		{
			if (!_bitmap) return;
			canvas.blit(_bitmap, x, y, transform.clone());
		}
		
		public function set bitmap(value:BitmapData):void 
		{
			_bitmap = value;
		}
		
		public function get transform():Matrix { return _transform; }
		
		public function set transform(value:Matrix):void 
		{
			_transform = value;
		}
		
	}

}