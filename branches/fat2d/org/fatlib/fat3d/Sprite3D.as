package org.fatlib.fat3d 
{
	import org.fatlib.fat3d.Object3D;
	
	/**
	 * ...
	 * @author 
	 */
	public class Sprite3D extends Object3D
	{
		
		public function Sprite3D() 
		{
					_container = new Sprite();
			_container.mouseChildren = false;
			_container.mouseEnabled = false;
			_userData = { };	
		}
		
			public function get display():DisplayObjectContainer { return _container; }
		
		public function getImage():DisplayObject { return _displayObject; }
		
		public function setImage(g:*):void 
		{
			_displayObject = g as DisplayObject;
			_container.addChild(_displayObject);
		}
		
		public function removeGraphic():DisplayObject
		{
			return _container.removeChild(_displayObject);
		}
		
		public function set scale(s:Number):void
		{
			_scale = s;
		}
		
		public function get scale():Number { return _scale; }
			public function set mouseEnabled(b:Boolean):void
		{
			_container.mouseEnabled = _container.mouseChildren = b;
		}

			
		public function destroy():void
		{
			_container.removeChild(_graphic);
		}
		
		
	}

}