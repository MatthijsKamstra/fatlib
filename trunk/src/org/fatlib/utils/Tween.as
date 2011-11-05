package org.fatlib.utils 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * A lightweight tweening class used to change an object's properties over time.
	 * 
	 * Usage:
	 * 
	 * var s:Sprite=new Sprite();
	 * Tween.add(s, 1000, {x:100, y:100}, transition:Tween.LINEAR, myMethod, [1]);
	 * 
	 * Tweens the sprite's position to (100, 100) over 1 second (1000ms) linearly, then calls myMethod passing a parameter of 1.
	 * 
	 */
	public class Tween
	{
		/**
		 * A linear tween
		 */
		public static const LINEAR:String = 'linear';
		
		/**
		 * Starts fast, slows down as reaches target
		 */
		public static const EASE_IN:String = 'ease_in';
		
		/**
		 * Starts slow, speeds up as reaches target
		 */
		public static const EASE_OUT:String = 'ease_out';
		
		/**
		 * Starts slow, speeds up then slows down as reaches target
		 */
		public static const EASE_IN_OUT:String = 'ease_in_out';
		
		
		private static var _activeTweens:Dictionary;
		
		/**
		 * Creates a tween on the specified target
		 * 
		 * @param	target			The object to tween
		 * @param	milliseconds	The duration of the tween
		 * @param	properties		A hash of properties to tween to
		 * @param	transition		The transition type
		 * @param	onComplete		The method to call when done
		 * @param	onCompleteParams	Parameters to pass to the onComplete method
		 */
		public static function add(target:Object, milliseconds:Number, properties:Object, transition:String = null, onComplete:Function = null, onCompleteParams:Array = null):void
		{
			if (!_activeTweens)_activeTweens = new Dictionary(false);
			var t:TweenInstance = new TweenInstance( target, milliseconds, properties, transition, onComplete, onCompleteParams);
			_activeTweens[t] = 1;
			t.addEventListener(Event.COMPLETE, onTweenComplete,false,0,true);
			t.start();
		}
		
		
		static private function onTweenComplete(e:Event):void 
		{
			var t:TweenInstance = e.target as TweenInstance;
			delete _activeTweens[t];
			t.doCompleteAction();
		}
		
	}
	
}

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;
import org.fatlib.process.Callback;
import org.fatlib.utils.Tween;

internal class TweenInstance extends EventDispatcher
{
	private var _target:Object;
	private var _duration:Number;
	private var _propertyList:Array;
	private var _transition:String;
	private var _onComplete:Callback;
	private var _frameSource:MovieClip;
	private var _startTime:int;
	
	[Event(name="complete", type="flash.events.Event")]
	
	public function TweenInstance(target:Object, milliseconds:Number, properties:Object, transition:String=null, onComplete:Function=null, onCompleteParams:Array=null) 
	{
		_target = target;
		_duration = milliseconds ;
		_transition = transition;
		if (!_transition)_transition = 'ease_in'
		if (onComplete != null)
			_onComplete = new Callback(onComplete, onCompleteParams);
	
		_frameSource = new MovieClip();
		
		_propertyList = new Array();
		for (var key:String in properties)
		{
			var from:Number = _target[key];
			var to:Number = properties[key];
			var property:Object = { key:key, from:from, to:to };
			_propertyList.push(property);
		}
	}
	
	internal function start():void
	{
		_startTime = getTimer();
		_frameSource.addEventListener(Event.ENTER_FRAME, onFrame, false,0,true);
	}
	
	private function onFrame(e:Event):void 
	{
		var elapsedTime:Number = getTimer() - _startTime;
		if (elapsedTime >= _duration)
		{
			updateProgress(1);
			done();
		} else {
			var progress:Number = elapsedTime / _duration;
			updateProgress(progress);
		}
	}
	
	private function updateProgress(progress:Number):void
	{
		var delta:Number;
		switch(_transition)
		{
			case 'linear':
				delta = progress;
				break;
			case 'ease_in':
				delta = progress * progress;
				break;
			case 'ease_out':
				delta = 1 - ((1 - progress) * (1 - progress));
				break;
			case 'ease_in_out':
				delta = (Math.sin((progress * Math.PI) - Math.PI / 2) + 1) / 2;
				break;
		}
		
		for each (var prop:Object in _propertyList)
		{
			var key:String = prop['key'];
			var from:Number = prop['from'];
			var to:Number = prop['to'];
			_target[key] = from + (delta * (to - from));
		}
	}
	
	private function done():void
	{
		_frameSource.removeEventListener(Event.ENTER_FRAME, onFrame);
		_frameSource = null;
		_target = null;
		_propertyList = null;
		dispatchEvent(new Event(Event.COMPLETE));
		
	}
	
	internal function doCompleteAction():void
	{
		if (_onComplete != null)_onComplete.execute();
	}
	
}
	
