package org.fatlib.fat3d
{
	
	/**
	* ...
	* @author fritz solares <hello@fritzsolares.com>
	*/
	public class Camera3D extends Object3D
	{
		protected var _focalLength:Number = 550;
		
		public function Camera3D() 
		{
			
		}
		
		///////////////
		
		public function get focalLength():Number { return _focalLength; }
		
		public function set focalLength(value:Number):void 
		{
			_focalLength = value;
		}
		
		/*
		 public function clone():Object3D
		{
			var r:Camera3D = new Camera3D();
			r.x = x;
			r.y = y;
			r.z = z;
			r.angleX = angleX;
			r.angleY = angleY;
			r.angleZ = angleZ;
			r.focalLength = focalLength;
			return r;
		}
		*/
	}
	
}

