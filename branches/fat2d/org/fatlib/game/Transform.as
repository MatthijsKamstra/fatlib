package org.fatlib.game 
{
	import org.fatlib.struct.Component;

	public class Transform extends Component
	{
	
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _z:Number = 0;
		
		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var _rotationZ:Number = 0;
		
		private var _scale:Number = 1;
		
		public function Transform() 
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
		
		public function get z():Number { return _z; }
		
		public function set z(value:Number):void 
		{
			_z = value;
		}
		
		public function get rotationX():Number { return _rotationX; }
		
		public function set rotationX(value:Number):void 
		{
			_rotationX = value;
		}
		
		public function get rotationY():Number { return _rotationY; }
		
		public function set rotationY(value:Number):void 
		{
			_rotationY = value;
		}
		
		public function get rotationZ():Number { return _rotationZ; }
		
		public function set rotationZ(value:Number):void 
		{
			_rotationZ = value;
		}
		
		/**
		 * for 2d sprites
		 */
		public function get rotation():Number
		{
			return _rotationZ;
		}
		
		public function set rotation(value:Number):void
		{
			_rotationZ = value;
		}
		
		public function get scale():Number { return _scale; }
		
		public function set scale(value:Number):void 
		{
			_scale = value;
		}
		
	}

}