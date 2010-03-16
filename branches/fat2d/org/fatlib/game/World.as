package org.fatlib.game 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.fatlib.game.standard.Canvas;
	import org.fatlib.interfaces.IDisplayable;
	
	public class World extends GameObject implements IDisplayable
	{
		private var _display:DisplayObjectContainer;
		private var _canvas:Canvas;
		private var _camera:GameObject;
		
		public function World() 
		{
			super();
			_display = new Sprite();
			camera = new GameObject();
		}
		
		public function get display():DisplayObjectContainer
		{
			return _display;
		}
		
		public function get canvas():Canvas { return _canvas; }
		
		public function set canvas(value:Canvas):void 
		{
			if (_canvas)
			{
				_display.removeChild(_canvas.display);
				remove(_canvas.name);
			}
			_canvas = value;
			_canvas.name = 'canvas';
			_display.addChild(_canvas.display);
			add(_canvas);
		}
		
		public function get camera():GameObject { return _camera; }
		
		public function set camera(value:GameObject):void 
		{
			if (_camera)
			{
				remove(_camera.name);
			}
			_camera = value;
			_camera.name = 'camera';
			add(_camera);
		}
		
	}

}