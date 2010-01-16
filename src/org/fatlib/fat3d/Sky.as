package org.fatlib.fat3d
{
	import flash.display.*;
	import org.fatlib.utils.MathUtils;
		
	/**
	* ...
	* @author fritz solares <hello@fritzsolares.com>
	*/
	public class Sky extends Sprite
	{
		private var _length:Number;
		private var seg1:Bitmap;
		private var seg2:Bitmap;
		
		public function Sky(bmp:BitmapData) 
		{
			seg1 = new Bitmap(bmp);
			seg2 = new Bitmap(bmp);
			addChild(seg1);
			addChild(seg2);
			_length = bmp.width;
			seg2.x = _length;
			y = -52;	
		}
		
		public function render(camera:Camera3D):void
		{
			x = -(camera.angleY * (_length / ( 2 * Math.PI)));
			while (x > 0) x -= _length;
			x = x % 2880;
		}
		
		public function destroy():void
		{
			removeChild(seg1);
			removeChild(seg2);
		}
	}
	
}