package org.fatlib.fat2d 
{
	import flash.geom.Matrix;
	import org.fatlib.interfaces.ICloneable;
	import org.fatlib.interfaces.IDestroyable;
	
	public class Object2D implements IDestroyable
	{
		
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function Object2D() 
		{
		}
		
		public function update(timeStep:Number = 0):void
		{
		}
		
		public function render(canvas:Canvas = null):void
		{
		}
		
		public function destroy():void
		{
		}
		
		public function get x():Number { return _x; }
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number { return _y; }
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		
		
	}

}