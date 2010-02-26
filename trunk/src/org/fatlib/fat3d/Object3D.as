package org.fatlib.fat3d
{
	import flash.display.*;
	import org.fatlib.interfaces.ICloneable;
	import org.fatlib.interfaces.IDestroyable

	public class Object3D implements IDestroyable
	{
		private var _x:Number=0;
		private var _y:Number=0;
		private var _z:Number=0;
		
		private var _angleX:Number=0;
		private var _angleY:Number=0;
		private var _angleZ:Number=0;
		
		private var _graphic:DisplayObject;
		private var _container:Sprite;
		
		private var _scale:Number = 1;
		private var _name:String;
		
		private var _fixedSize:Boolean = false;
		
		public function Object3D()
		{
			_container = new Sprite();
			_container.mouseChildren = false;
			_container.mouseEnabled = false;
		}
			
		public function destroy():void
		{
			_container.removeChild(_graphic);
		}
		
		public function set mouseEnabled(b:Boolean):void
		{
			_container.mouseEnabled = _container.mouseChildren = b;
		}
			
		public function setParams(params:Object):void
		{
			if (params['x'])x = params['x'];
			if (params['y'])y = params['y'];
			if (params['z'])z = params['z'];
			if (params['angleX'])angleX = params['angleX'];
			if (params['angleY'])angleY = params['angleY'];
			if (params['angleZ'])angleZ = params['angleZ'];
			if (params['scale'])angleZ = params['scale'];
		}
		
		public function render(camera:Camera3D):void
		{
		}
		
		//////////// getters, setters
	
			
		internal function get container():Sprite { return _container; }
		
		public function get graphic():DisplayObject { return _graphic; }
		
		public function set graphic(g:*):void 
		{
			_graphic = g as DisplayObject;
			_container.addChild(_graphic);
		}
		
		public function removeGraphic():DisplayObject
		{
			return _container.removeChild(_graphic);
		}
		
		public function set scale(s:Number):void
		{
			_scale = s;
		}
		
		public function get scale():Number { return _scale; }
						
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