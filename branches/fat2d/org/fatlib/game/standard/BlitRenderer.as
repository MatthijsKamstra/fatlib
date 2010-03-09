package org.fatlib.game.standard
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
	
	public class BlitRenderer extends GameComponent implements IBlittable
	{
		private var _bitmap:BitmapData;
		private var _centre:Point;
		private var _target:IBlittable;
		
		public function BlitRenderer(target:IBlittable = null, bitmap:BitmapData = null) 
		{
			super();
			_centre = new Point();
			_bitmap = bitmap;
			_target = target;
		}
		
		public function get target():IBlittable
		{
			if (!_target) return null;
			//if (!gameObject.world) return null;
			return(_target);
		//	return (gameObject.world.getChild('canvas') as IBlittable)
			//return (gameObject.world as IBlittable);
		}
		
		override public function render(params:* = null):void 
		{
			//return;trac
			
			if (!target) return;
			/*
			var m:Matrix = new Matrix();
			m.scale(gameObject.scale, gameObject.scale);
			m.translate( -centre.x * scale, -centre.y * scale);
			m.rotate(_rotation);
			m.translate(_x, _y);
			blit(_target, _bitmap.rect, m);
	*/
			
			var m:Matrix = new Matrix();
			//m.
			m.translate( -centre.x, -centre.y);
			m.scale(gameObject.transform.scale, gameObject.transform.scale);
			m.rotate(gameObject.transform.rotation);
			m.translate(gameObject.transform.x, gameObject.transform.y);
			//m.createBox(gameObject.scale, gameObject.scale, gameObject.rotation, gameObject.x + centre.x, gameObject.y + centre.y);
			blit(bitmap, bitmap.rect, m);
		}
			
		public function blit(source:BitmapData, sourceRect:Rectangle, transform:Matrix):void
		{
			target.blit(source, sourceRect, transform);
		}

		public function fill(color:uint):void
		{
			//bitmap=new BitmapData(_bitmap.width, _bitmap.width, true , color);
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
		public function drawEmbeddedImage(imgClass:Class, centre:Boolean = true):void
		{
			bitmap = (new imgClass).bitmapData;
			if (centre)this.centre = new Point(bitmap.width / 2, bitmap.height / 2);
		}
		
		public function drawText(text:String, color:int = 0xFF0000, x:Number = 0, y:Number = 0):void
		{
			DisplayUtils.drawText(text, this.bitmap, color, new Point(x, y));
		}
		
	
		/* INTERFACE org.fatlib.interfaces.IBlittable */
		
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