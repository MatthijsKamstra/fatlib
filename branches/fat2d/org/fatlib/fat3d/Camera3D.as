package org.fatlib.fat3d
{
	
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
		
	}
	
}

