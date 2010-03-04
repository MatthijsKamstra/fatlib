package org.fatlib.fat2d 
{
	public class Object2D implements IEntity
	{
		
		private var _x:Number;
		private var _y:Number;
		
		public function Object2D() 
		{
		}
		
		public function update(timeStep:Number = 0):void
		{
		}
		
		public function render(canvas:Canvas = null):void
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