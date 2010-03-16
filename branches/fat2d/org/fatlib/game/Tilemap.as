package org.fatlib.game 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.fatlib.game.GameComponent;
	import org.fatlib.game.interfaces.IBlittable;
	import org.fatlib.game.standard.BlitRenderer;
	import org.fatlib.game.standard.Canvas;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.struct.Grid;
	import org.fatlib.utils.MathUtils;
	
	public class Tilemap extends GameObject
	{
		
		private var _data:Grid;
		private var _target:IBlittable;
		
		private var _tileW:int=50;
		private var _tileH:int = 50;
		private var _spriteSheet:BitmapData;
		
		public function Tilemap(target:IBlittable, width:uint, height:uint) 
		{
			super();
			_target = target;
			_data = new Grid(width, height);
		}
		
		override public function render(params:* = null):void 
		{
			var w:Number = _target.width;
			var h:Number = _target.height;
			
			var tilesX:int = w / _tileW;
			var tilesY:int = h / _tileH;
			for (var i:int = -2; i < tilesX+2; i++)
				for (var j:int = -2; j < tilesY+2; j++)
				{
					var x:Number = camera.transform.x + (i * _tileW) - (w/2);
					var y:Number = camera.transform.y + (j * _tileH) - (h / 2);
					
					var cell:int = _data.getCell(x / _tileW, y / _tileH);
					var t:Matrix = new Matrix(1, 0, 0, 1, x - (x%_tileW), y -(y%_tileH));
					
					_target.blit(_spriteSheet, new Rectangle(_tileW * cell, 0, _tileW, _tileH), t);
				//	_target.blit(_tiles, _tiles.rect, t);
				}
		}
		
		public function get camera():GameObject 
		{
			if (parent is World) return (parent as World).camera;
			return new GameObject();
		}
		
		public function get data():Grid { return _data; }
		
		public function set data(value:Grid):void 
		{
			_data = value;
		}
		
		public function get width():uint
		{
			return _data.width;
		}
		
		public function get height():uint
		{
			return _data.height;
		}
		
		public function setTileSheet(value:BitmapData, tileWidth:int = 0, tileHeight:int = 0):void 
		{
			_spriteSheet = value;
			if (tileWidth == 0) tileWidth = value.width;
			if (tileHeight == 0) tileHeight = value.height;
			_tileW = tileWidth;
			_tileH = tileHeight;
		}
		
		

	}

}