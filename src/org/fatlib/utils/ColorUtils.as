package org.fatlib.utils 
{
	
	/**
	 * Provides methods dealing with color
	 */
	public class ColorUtils 
	{
		
		/**
		 * Returns an array of different color RGB values
		 * @return	an array of different color RGB values
		 */
		public static function getColorList():Array
		{
			var cols:Array = [];
			for (var r:int = 2; r <= 3; r++)
				for (var g:int = 1; g <= 3;  g++)
					for (var b:int = 1; b <= 3; b++)
					{
						var col:int = (r * 80 * 256 * 256) + (g * 80 * 256) + (b * 80);
						cols.push(col);
					}
			
			return cols;
		}
		
		/**
		 * Returns an array of random color RGB values
		 * 
		 * @param	num	The number of colors in the list
		 * @return	An array of random color RGB values
		 */
		public static function getRandomColors(num:int):Array
		{
			var cols:Array = getColorList();
			if (num > cols.length) num = cols.length;
			cols = ArrayUtils.shuffle(cols);
			return cols.slice(0, num);
		}
		
		/**
		 * Converts a hex color integer (eg. 0xFF0000) into its RGB components (eg. {r:255, g:0, b:0})
		 * 
		 * @param	color	The hex value to convert
		 * @return	An object with properties r, g, b representing the component color values
		 */
		public static function hexToRGB(color:int):Object
		{
			var r:int = ( color >>> 16 ) & 255;
			var g:int = ( color >>> 8 ) & 255;
			var b:int = ( color ) & 255;
			return { 'r':r, 'g':g, 'b':b };
		}
		
		public static function rgbToHex(rgb:Object):int
		{
			return rgb.b + (rgb.g * 256) + (rgb.r * 256 * 256);
		}
		
		public static function gray(byte:uint):int
		{
			if (byte > 255) byte = 255;
			return byte + (byte * 256) + (byte * 256 * 256);
		}
		
	}
	
}