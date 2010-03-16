package org.fatlib.game.standard
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.fatlib.game.GameComponent;
	import org.fatlib.game.GameObject;
	import org.fatlib.game.interfaces.IBlittable;
	import org.fatlib.game.Transform;
	import org.fatlib.game.World;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.game.GameComponent;
	import org.fatlib.utils.ColorUtils;
	import org.fatlib.utils.DisplayUtils;
	
	public class Canvas extends GameComponent implements IDisplayable, IBlittable
	{
		private var _display:Sprite;
		private var _width:int;
		private var _height:int;
		private var _fillColor:int = 0x333333;
		private var _rect:Rectangle;
		private var _bitmap:BitmapData;
		private var _camera:GameObject;
		
		public function Canvas(width:int, height:int, fillColor:Number = 0xFF333333) 
		{
			super();
			_width = width;
			_height = height;
			_fillColor = fillColor;
			_bitmap = new BitmapData(_width, _height, false, _fillColor);
			_display = new Sprite();
			_display.addChild(new Bitmap(_bitmap));
			_rect = new Rectangle(0, 0, _width, _height);
		}
		
		
		
		public function get display():DisplayObjectContainer
		{
			return _display;
		}
		
		public function get bitmap():BitmapData { return _bitmap; }
		
		public function get width():int { return _width; }
		
		public function get height():int { return _height; }
		
		public function get fillColor():int { return _fillColor; }
		
		public function get camera():GameObject 
		{ 
			if (!_camera) if (parent is World) return (parent as World).camera;
			return _camera; 
		}
		
		public function set camera(value:GameObject):void 
		{
			_camera = value;
		}
		
		public function blit(source:BitmapData, sourceRect:Rectangle = null, transform:Matrix = null):void
		{
			
			if (sourceRect == null) sourceRect = source.rect;
			if (transform == null) transform = new Matrix();
			transform.scale(camera.transform.scale, camera.transform.scale);
			transform.translate( width / 2 - camera.transform.scale * camera.transform.x, height / 2 - camera.transform.scale * camera.transform.y);
			
			//if (transform.tx<0 || transform.tx>_width || transform.ty<0 || transform.ty>_height)return;
			DisplayUtils.blit(source, _bitmap, sourceRect, transform);
		}
		
		override public function render(params:* = null):void 
		{
			fill(_fillColor);
		}
		
		public function fill(color:uint):void
		{
			_bitmap.fillRect(_bitmap.rect, _fillColor);
		}
		
	}
}