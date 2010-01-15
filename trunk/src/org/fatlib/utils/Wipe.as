package org.fatlib.utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * A wipe animation, implemented by revealing an object by creating and tweening a mask
	 */
	public class Wipe
	{
		
		public static const LEFT:String = 'L';
		public static const RIGHT:String = 'R';
		public static const TOP:String = 'T';
		public static const BOTTOM:String = 'B';
		
		public static const TOP_LEFT:String = 'TL';
		public static const TOP_RIGHT:String = 'TR';
		public static const BOTTOM_LEFT:String = 'BL';
		public static const BOTTOM_RIGHT:String = 'BR';
		
		private static var _activeWipes:Dictionary;
		
		/**
		 * Add a wipe reveal animation
		 * 
		 * @param	target				The display object to be revealed
		 * @param	milliseconds		The duration of the animation
		 * @param	from				The direction to wipe from - LEFT, RIGHT, TOP, BOTTOM etc
		 * @param	transition			The Tween transistion to use
		 * @param	onComplete			A method to call when done
		 * @param	onCompleteParams	Parameters to pass to the onComplete method
		 */	
		public static function add(target:DisplayObject, milliseconds:Number, from:String, transition:String = null, onComplete:Function = null, onCompleteParams:Array = null):void
		{
			if (!_activeWipes)_activeWipes = new Dictionary(false);
			var w:WipeInstance = new WipeInstance();
			_activeWipes[w] = 1;
			w.addEventListener(Event.COMPLETE, onWipeComplete);
			w.start( target, milliseconds,from, transition, onComplete, onCompleteParams);
		}
		
		static private function onWipeComplete(e:Event):void 
		{
			var w:WipeInstance = e.target as WipeInstance;
			delete _activeWipes[w];
			w.doCompleteAction();
		}
		
	}
	
}

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;
import flash.utils.getTimer;
import org.fatlib.interfaces.IIterator;
import org.fatlib.iterators.CharIterator;
import org.fatlib.process.Callback;
import org.fatlib.utils.Tween;
import org.fatlib.utils.DisplayUtils

internal class WipeInstance extends EventDispatcher
{
	private var _target:DisplayObject;
	private var _mask:Sprite;
	private var _onCompletecallback:Callback;	
	
	public function WipeInstance()
	{
	}
	
	internal function start(target:DisplayObject, milliseconds:Number, from:String, transition:String=null, onComplete:Function=null, onCompleteParams:Array=null):void
	{
		_target = target;
		var rect:Rectangle = target.getRect(target.parent);
		
		_mask = DisplayUtils.createRectangle(rect.left, rect.top, target.width, target.height);
		_target.parent.addChild(_mask);
		_target.mask = _mask;
	
		var ox:Number = _mask.x;
		var oy:Number = _mask.y;
		
		var it:IIterator = new CharIterator(from);
		while (it.hasNext)
		{
			switch(it.next)
			{
				case 'L':
					_mask.x -= _mask.width;
					break;
				case 'R':
					_mask.x += _mask.width;
					break;
				case 'T':
					_mask.y -= _mask.height;
					break;
				case 'B':
					_mask.y += _mask.height;
					break;
			}	
		}
		
		if (onComplete!=null)
			_onCompletecallback = new Callback(onComplete, onCompleteParams);
		
		Tween.add(_mask, milliseconds, { x:ox, y:oy }, transition, tweenDone);
		
	}
	
	private function tweenDone():void
	{
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	internal function doCompleteAction():void
	{
		_target.mask = null;
		_mask.parent.removeChild(_mask);
		if (_onCompletecallback)
			_onCompletecallback.execute();
	}
	
}
	
