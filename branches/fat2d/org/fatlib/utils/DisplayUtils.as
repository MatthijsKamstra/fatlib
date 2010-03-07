package org.fatlib.utils
{
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.fatlib.display.Button;
	import org.fatlib.display.Text;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.iterators.ArrayIterator;
	import org.fatlib.iterators.ChildIterator;
	

	/**
	 * Provides display-related helper methods
	 */
	public class DisplayUtils 
	{
		
		/**
		 * Recursively calls stop() on all MovieClip children of the given DisplayObject
		 * @param	obj	The DisplayObject to recursively stop
		 */
		public static function recursiveStop(obj:DisplayObject):void
		{
			if (obj is MovieClip)
					(obj as MovieClip).stop();
					
			if (obj is DisplayObjectContainer)
			{
					var container:DisplayObjectContainer = obj as DisplayObjectContainer;
					for (var i:int = 0; i < container.numChildren; i++)
					{
						var child:DisplayObject = container.getChildAt(i);
						recursiveStop(child);
					}
			}
		}
		
		/**
		 * Check whether a MovieClip has a frame with the given name
		 * @param	mc	The	MovieClip to check 
		 * @param	frameName	The name of the frame to check 
		 * @return	Whether the MovieClip has a frame with the given name
		 */
		public static function hasFrame(mc:MovieClip, frameName:String):Boolean
		{
			
				var i:IIterator = new ArrayIterator(mc.currentLabels);
				while (i.hasNext)
						if ((i.next as FrameLabel).name == frameName)
								return true;
				return false;
		}
		
		/**
		 * Removes all the children of the specified target
		 * @param	target	The object to remove children from
		 */
		public static function removeChildren(target:DisplayObjectContainer):void
		{
			var it:ChildIterator = new ChildIterator(target);
			while (it.hasNext)
			{
				target.removeChild(it.next as DisplayObject);
			}
		}				
		
		/**
		 * Creates a Sprite with a circle drawn onto its 'graphics' property
		 * @param	radius	The radius of the circle
		 * @param	col		The color of the circle
		 * @return	A Sprite with a circle drawn onto its 'graphics' property
		 */
		public static function createCircle(radius:Number = 5, col:int = 0x999999, border:Boolean = false):Sprite
		{
			var b:Sprite = new Sprite();
			b.graphics.clear();
			if (border) b.graphics.lineStyle(1, 0);
			b.graphics.beginFill(col);
			b.graphics.drawCircle(0, 0, radius);
			b.graphics.endFill();
			return b;
		}
		
		/**
		 * Creates a Sprite with a rectangle drawn onto its 'graphics' property
		 * @param	x	The x value of the rectangle, relative to the returned Sprite
		 * @param	y	The x value of the rectangle, relative to the returned Sprite
		 * @param	w	The width of the rectangle
		 * @param	h	The height of the rectangle
		 * @param	col	The color of the rectanhle
		 * @return	a Sprite with a rectangle drawn onto its 'graphics' property
		 */
		public static function createRectangle(x:Number, y:Number, w:Number, h:Number, col:int = 0x000000, border:Boolean = false):Sprite
		{
			var b:Sprite = new Sprite();
			b.graphics.clear();
			if (border) b.graphics.lineStyle(1, 0);
			b.graphics.beginFill(col);
			b.graphics.drawRect(x, y, w, h);
			b.graphics.endFill();
			return b;
		}
					
		
		/**
		 * Centres the object, based on its current width and height, to a target's centre
		 */
		public static function centreTo(o:DisplayObject, target:DisplayObject):void
		{
			o.x = target.x +(target.width / 2)  - (o.width / 2);
			o.y = target.y +(target.height / 2) -  (o.height / 2);
		}
		
		
		/**
		 * Centres the object, based on its current width and height, to its parent's (0,0) parent.
		 * If the object has no parent, does nothing.
		 */
		public static function centreToParent(o:DisplayObject):void
		{
			var p:DisplayObjectContainer = o.parent;
			if (!p) return;
			var cx:Number = p.width / 2;
			var cy:Number = p.height / 2;
			o.x = cx - (o.width / 2);
			o.y = cy - (o.height / 2);
		}
		
		/**
		 * Centres the object, based on its current width and height, to its (0,0) point
		 */
		public static function centre(o:DisplayObject):void
		{
			o.x = - (o.width / 2);
			o.y = - (o.height / 2);		
		}
		
		
		/**
		 * Automatically assigns a tab order to all the children of an display object container.
		 * 
		 * 
		 * 
		 * @param	o	The display object container to assign tab orders to
		 */
		public static function assignTabOrder(o:DisplayObjectContainer):void
		{
			var children:Array = getChildren(o);
			
			var tabbables:Array = [];
			
			for each(var c:DisplayObject in children)
			{
				if (c is InteractiveObject) 
				{
					//var g:Graphic;
					//if (c is Graphic) g = c as Graphic;
					
					if ((c as InteractiveObject).tabEnabled)
					{
						tabbables.push(c);
					}
				}
			}
			
			var sortList:Array = [];
			for (var i:int = 0; i < tabbables.length; i++)
			{
				var t:InteractiveObject = tabbables[i];
				var rect:Rectangle = t.getRect(t.parent);
				var p:Point = new Point(rect.left + t.width / 2, rect.top + t.height / 2);
				p = t.localToGlobal(p);
				var score:Number = p.y + (p.x / t.stage.height);
				sortList.push( { obj:t, score:score } );
				
			}
			
			sortList.sortOn("score", Array.NUMERIC);
			
			
			for (i=0; i < sortList.length; i++)
			{
				t = sortList[i]['obj'];
				t.tabIndex = i;
			}
			
			
		}
		
		private static function getChildren(o:DisplayObjectContainer, children:Array = null):Array
		{
			if (!children) children = [];
			var it:IIterator = new ChildIterator(o);
			while (it.hasNext)
			{
				var c:DisplayObject = it.next;
				children.push(c);
				if (c is DisplayObjectContainer)
				{
					children.concat(getChildren(c as DisplayObjectContainer, children));
				}
			}
			return children;
		}
		
		public static function drawText(text:String, target:BitmapData, color:int = 0xFF0000, position:Point = null):void
		{
			if (position == null) position = new Point();
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			t.text = text;
			t.textColor = color;
			var m:Matrix = new Matrix();
			m.translate(position.x, position.y);
			target.draw(t, m);
		}
		
	}
	
}
