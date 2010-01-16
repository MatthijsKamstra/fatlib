package org.fatlib.fat3d
{
	public class Point3D 
	{
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function Point3D(x:Number = 0, y:Number = 0, z:Number = 0 ) 
		{
			_x = x;
			_y = y;
			_z = z;
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
		
		public function get z():Number { return _z; }
		
		public function set z(value:Number):void 
		{
			_z = value;
		}
		
		public function toString():String 
		{
			return '[Point3D ' + x + ', ' + y + ', ' + z + ']';
		}
		
	}
	
}