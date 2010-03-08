package org.fatlib.game 
{
	public class Entity extends GameComponent
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _rotation:Number = 0;
		private var _scale:Number = 1;
		
		public function Entity() 
		{
			super();
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
		
		public function get rotation():Number { return _rotation; }
		
		public function set rotation(value:Number):void 
		{
			_rotation = value;
		}
		
		public function get scale():Number { return _scale; }
		
		public function set scale(value:Number):void 
		{
			_scale = value;
		}
	}

}