package org.fatlib.fat2d 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.fatlib.game.GameComponent;
	import org.fatlib.interfaces.IBlittable;
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.utils.DisplayUtils;
	
	public class Sprite2D extends GameComponent implements IBlittable
	{
		private var _bitmap:BitmapData;
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _rotation:Number = 0;
		private var _scale:Number = 1;
		private var _centre:Point;
		
		public function Sprite2D() 
		{
			super();
			_centre = new Point();
		}
		
		override protected function handleRender(params:* = null):void 
		{
			if (!_bitmap) return;
			var m:Matrix = new Matrix();
			m.scale(_scale, _scale);
			m.translate( -centre.x * scale, -centre.y * scale);
			m.rotate(_rotation);
		//	m.translate(centre.x * scale, centre.y * scale);
		//	m.translate(_x - centre.x * _scale, _y - centre.y * _scale);
			m.translate(_x, _y);
			blit(_bitmap, _bitmap.rect, m);
	
		}
			

		public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			var m:Matrix = transform.clone();
			if (parent is Sprite2D)
			{
				var p:Sprite2D = parent as Sprite2D;
				m.scale(p.scale, p.scale);
				m.rotate(p.rotation);
				m.translate(p.x, p.y);
			}
			(parent as IBlittable).blit(source, source.rect, m);
		}
	
		
		
		/**
		 * Use with images embedded [Embed]
		 * eg. 
		 * [Embed(source = 'data/jupiter.gif')]	private static var Planet:Class;
		 * 
		 * E(Planet);
		 * 
		 * 
		 * @param	imgClass
		 */
		public function drawEmbeddedImage(imgClass:Class):void
		{
			bitmap = (new imgClass).bitmapData;
		}
		
		public function drawText(text:String, color:int = 0xFF0000, x:Number = 0, y:Number = 0):void
		{
			DisplayUtils.drawText(text, this.bitmap, color, new Point(x, y));
		}
		
		public function centreToBitmap():void
		{
			centre = new Point(_bitmap.width / 2, _bitmap.height / 2);
		}
		
		/* INTERFACE org.fatlib.interfaces.IBlittable */
		
		public function fill(color:uint):void
		{
			_bitmap = new BitmapData(bitmap.width, bitmap.height, true, color);
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
		
		public function get rotation():Number { return _rotation; }
		
		public function set rotation(value:Number):void 
		{
			_rotation = value;
		}
		
		public function get scale():Number { return _scale; }
		
		public function set scale(value:Number):void 
		{
			_scale = value;
		}
		
		public function get bitmap():BitmapData { return _bitmap; }
		
		public function set bitmap(value:BitmapData):void 
		{
			_bitmap = value;
		}
		
		public function get centre():Point { return _centre; }
		
		public function set centre(value:Point):void 
		{
			_centre = value;
		}
		
		
		
		
		
	}

}