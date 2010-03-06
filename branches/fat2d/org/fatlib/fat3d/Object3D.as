package org.fatlib.fat3d
{
	import flash.display.*;
	import org.fatlib.game.GameComponent;
	import org.fatlib.interfaces.IDestroyable
	import org.fatlib.interfaces.IDisplayable;

	public class Object3D extends GameComponent
	{
		private var _x:Number=0;
		private var _y:Number=0;
		private var _z:Number=0;
		
		private var _rotationX:Number=0;
		private var _rotationY:Number=0;
		private var _rotationZ:Number=0;
		
		private var _scale:Number = 1;
		private var _fixedSize:Boolean = false;
		
		
		public function Object3D()
		{
		}
			
		public function update(timeStep:Number = 0):void 
		{
		}
	

		//////////// getters, setters
			
						
		public function get name():String { return _name; }
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get angleX():Number { return _angleX; }
		
		public function set angleX(value:Number):void 
		{
			_angleX = value;
		}
		
		public function get angleY():Number { return _angleY; }
		
		public function set angleY(value:Number):void 
		{
			_angleY = value;
		}
		
		public function get angleZ():Number { return _angleZ; }
		
		public function set angleZ(value:Number):void 
		{
			_angleZ = value;
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
		
		public function set position(p:Point3D): void
		{
			_x = p.x;
			_y = p.y;
			_z = p.z;
		}
		
		public function get position():Point3D
		{
			return new Point3D(x, y, z);
		}
		
		public function get fixedSize():Boolean { return _fixedSize; }
		
		public function set fixedSize(value:Boolean):void 
		{
			_fixedSize = value;
		}
		
		public function get userData():Object { return _userData; }
		
		public function toString():String
		{
			var s:String = '[Object3D at ' + int(x) + ',' + int(y) + ',' + int(z) ;
			if (_angleX != 0) s += ', angleX=' + _angleX;
			if (_angleY != 0) s += ', angleY=' + _angleY;
			if (_angleZ != 0) s += ', angleZ=' + _angleZ;
			s += ']';
			return s;
			
		}
		

		
		
	}
}