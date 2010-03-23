package org.fatlib.struct 
{
	import org.fatlib.interfaces.ICloneable;
	import org.fatlib.interfaces.IIterable;
	import org.fatlib.interfaces.IIterator;
	
	/**
	 * A 2D array or grid data structure
	 */
	public class Grid implements IIterable, ICloneable
	{
		
		private var _cols:Array;
		private var _w:int;
		private var _h:int;
		
		/**
		 * A Creates a new instance
		 * 
		 * @param	w	The number of columns
		 * @param	h	The number of rows
		 */
		public function Grid(w:int, h:int) 
		{
			_w = w;
			_h = h;
			
			_cols = new Array();
			for (var i:int = 0; i < _w; i++)
			{
				var col:Array = new Array();
				for (var j:int = 0; j < _h; j++)
				{
					var cell:Object = { contents:null };
					col.push(cell);
				}
				_cols.push(col);
			}
		}
		
		/**
		 * Fill the grid with a value
		 * 
		 * @param	c	The value to fill the grid with 
		 */
		public function fill(c:*):void
		{
			for each(var col:Array in _cols)
				for each (var cell:Object in col)
					cell.contents = c;
		}
		
		/**
		 * Fill the grid with clones of an object
		 * 
		 * @param	c	The object to fill the grid with clones of
		 */
		public function fillWithClones(c:ICloneable):void
		{
			for each(var col:Array in _cols)
				for each (var cell:Object in col)
					cell.contents = c.clone();
		}
		
		/**
		 * Get the contents of a cell
		 * 
		 * @param	x	The x-position of the cell
		 * @param	y	The y-position of the cell
		 * @return	The contents of the specified cell
		 */
		public function getCell(x:int, y:int):*
		{
			if (x >= _w || x < 0 || y >= _h || y < 0) return null
			return _cols[x][y].contents;
		}
		
		/**
		 * Set the contents of a cell
		 * 
		 * @param	x	The x-position of the cell
		 * @param	y	The y-position of the cell
		 * @param	c	An object to fill the the specified cell with
		 */
		public function setCell(x:int, y:int, c:*):void
		{
			if (x >= _w || x < 0 || y >= _h || y < 0) return;
			_cols[x][y] = { contents:c };
		}
		
		
		/**
		 * Gets an iterator for the object
		 * 
		 * @return	An iterator for the object
		 */
		public function getIterator():IIterator
		{
			return new GridIterator(this);
		}
		
		public function clone():ICloneable
		{
			
			var copy:Grid = new Grid(width, height);
			for (var i:int = 0; i < width; i++)
			{
				for (var j:int = 0; j < height; j++)
				{
					var c:*= getCell(i, j);
					if (c is ICloneable)
					{
						copy.setCell(i, j, (c as ICloneable).clone());	
					} else {
						copy.setCell(i, j, c);
					}
				}
			}
			return copy;
		}
		
		public function get width():int { return _w; }
		public function get height():int { return _h; }
		
		
		
	}


}

import org.fatlib.iterators.ArrayIterator;
import org.fatlib.data.Grid;

internal class GridIterator extends ArrayIterator
{
	public function GridIterator(grid:Grid) 
	{
		var linear:Array = [];
		for (var i:int = 0; i < grid.width; i++)
			for (var j:int = 0; j < grid.height; j++)
				linear.push(grid.getCell(i, j));
		super(linear);
	}
}

