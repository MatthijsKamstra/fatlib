package org.fatlib.fat3d
{

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.fatlib.fat3d.Camera3D;
	import org.fatlib.game.GameComponent;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.utils.ArrayUtils;
	import org.fatlib.interfaces.IDestroyable;
	
	
	/*
	 *              z 
	 *            / 
	 *           .
	 *          /______x
	 *          ! 
	 *          !  
	 *          !   
	 *           y
	 */
	
	public class Fat3D extends GameComponent implements IDisplayable
	{
		
		private var _display:DisplayObjectContainer;
		private var _viewport:Rectangle;
		private var _camera:Camera3D;
		private var _scaleFactor:Number = 1;
		
		public function Fat3D(viewport:Rectangle)
		{
			_display = new Sprite();
			_viewport = viewport;
		}
		
		
		override protected function handleRender(params:* = null):void 
		{
			var viewX:Number = _viewport.x + _viewport.width / 2;
			var viewY:Number = _viewport.y + _viewport.height / 2;
			
			//http://en.wikipedia.org/wiki/Perspective_transform
			var sx:Number = Math.sin (_camera.angleX);
			var sy:Number = Math.sin (_camera.angleY);
			var sz:Number = Math.sin (_camera.angleZ);
			var cx:Number = Math.cos (_camera.angleX); 
			var cy:Number = Math.cos (_camera.angleY);
			var cz:Number = Math.cos (_camera.angleZ);
			var total:int = _objects.length;
			var depths:Array = new Array();
			var i:int = total;
			
			while ( --i != -1 ) 
			{
				var obj:Object3D = _objects[i]
				var difx:Number = obj.x - _camera.x;
				var dify:Number = obj.y - _camera.y;
				var difz:Number = obj.z - _camera.z;
				var rz1:Number = sz * dify + cz * difx;
				var rz2:Number = cz * dify - sz * difx;
				var dx:Number = cy * (sz * dify + cz * difx) - sy * difz;
				var dy:Number = sx * (cy * difz + sy * (rz1)) + cx * (rz2);
				var dz:Number = cx * (cy * difz  +sy * (rz1)) - sx * (rz2);
				obj.userData.renderInfo = { dx:dx, dy:dy, dz:dz };
				
				obj.render(_camera);
				if (!obj.container) continue;
				if ( dz<0) 
				{
					obj.container.visible = false;
				} else	{
					
					obj.container.visible = true;
					var depth:Number = dz;
					
					depths.push({ instance:obj, depth:depth });
					var f:Number = _camera.focalLength / dz;
					if (obj.fixedSize)
					{
						var scale:Number = 1;
					} else {
						scale= f * obj.scale * _scaleFactor;
					}
					var scrx:Number = viewX+(dx * f);
					var scry:Number = viewY + (dy * f);
					obj.userData.screenInfo = { x:scrx, y: scry };
					obj.container.transform.matrix = new Matrix(scale, 0, 0, scale, scrx, scry);
				}
			}
			
			depths.sortOn('depth', Array.NUMERIC);// | Array.DESCENDING);
			i = depths.length;
			
			while(--i!=-1)
			{
				var o:Object3D = depths[i].instance as Object3D;
				setChildIndex(o.container, numChildren - 1);
			}
		}
		
		public function set scaleFactor(value:Number):void 
		{
			_scaleFactor = value;
		}
		
		public function get display():DisplayObjectContainer { return _display; }
		
		public function get camera():Camera3D { return _camera; }
		
		public function set camera(value:Camera3D):void 
		{
			_camera = value;
		}
		
	}
}