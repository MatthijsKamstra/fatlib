package org.fatlib.game.standard
{
	import org.fatlib.game.GameComponent;
	import org.fatlib.game.GameObject;
	import org.fatlib.game.Transform;

	public class NavigateWaypointsBehavior extends GameComponent
	{
		
		public static const ONEWAY:String = 'oneway';
		public static const LOOP:String = 'loop';
		public static const PINGPONG:String = 'pingpong';
		
		private var _route:Array;
		private var _threshold:Number = 5;
		private var _currentIndex:int = 0;
		private var _speed:Number = 1;
		private var _xv:Number = 0;
		private var _yv:Number = 0;
		private var _currentTarget:Transform;
		private var _loop:Boolean;
		private var _mode:String;
		
		public function NavigateWaypointsBehavior(loop:Boolean = true) 
		{
			super();
			_route = [];
			_loop = loop;
		}
		
		public function addWaypoint(transform:Transform):void
		{
			_route.push(transform);
		}
		
		override public function update(timeStep:Number = 1):void
		{
			if (_route.length <= 1) return;
			gameObject.transform.x += _xv * timeStep;
			gameObject.transform.y += _yv * timeStep;
			if (!_currentTarget) findTarget();
			var dx:Number = (gameObject.transform.x -_currentTarget.x);
			var dy:Number = (gameObject.transform.y -_currentTarget.y);
			if (dx * dx + dy * dy < _threshold * _threshold)
			{
				findTarget();
			}
		}
		
		private function findTarget():void
		{
			_currentIndex++;
			if (_currentIndex == _route.length)
			{
				_currentTarget = gameObject.transform;
			} else {
				_currentTarget = _route[_currentIndex % _route.length];	
			}
			
			var dx:Number = (gameObject.transform.x - _currentTarget.x);
			var dy:Number = (gameObject.transform.y - _currentTarget.y);
			var angle:Number = Math.atan2(dy, dx);
			gameObject.transform.rotation = angle-Math.PI / 2;
			_xv = Math.cos(angle + Math.PI) * _speed; 
			_yv = Math.sin(angle + Math.PI) * _speed;
			
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
		}
	}

}