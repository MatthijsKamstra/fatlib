package org.fatlib.game 
{
	import org.fatlib.struct.Point3D;

	public class ParticleBehavior extends GameComponent
	{
		
		private var _xv:Number = 0;
		private var _yv:Number = 0;
		private var _zv:Number = 0;
		private var _xrv:Number = 0;
		private var _yrv:Number = 0;
		private var _zrv:Number = 0;
		private var _drag:Transform;
		
		override public function update(timeStep:Number = 1):void 
		{
			gameObject.transform.x += _xv;
			gameObject.transform.y += _yv;
			gameObject.transform.z += _zv;
			gameObject.transform.rotationX += _xrv;
			gameObject.transform.rotationY += _yrv;
			gameObject.transform.rotationZ += _zrv;
		}
		
		public function applyForce(force:Point3D):void
		{
			
		}
		
		public function get rv():Number { return _zrv; }
		
		public function set rv(value:Number):void 
		{
			_zrv = value;
		}
		
		
	}

}