package org.fatlib.utils
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import org.fatlib.events.CustomEvent;
	import org.fatlib.interfaces.IDestroyable;
	
	public class MovieClipListener extends EventDispatcher implements IDestroyable
	{
		
		private var _currentLabel:String;
		private var _mc:MovieClip;
		
		public function MovieClipListener(mc:MovieClip) 
		{
			_mc = mc;
			_mc.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
			_currentLabel = _mc.currentLabel;
		}
		
		private function onFrame(e:Event):void 
		{
			if (_mc.currentLabel != _currentLabel)
			{
				_currentLabel = _mc.currentLabel; 
				dispatchEvent(new CustomEvent(Event.CHANGE, _currentLabel));
			}
			
			if (_mc.currentFrame == _mc.totalFrames && _mc.totalFrames>1)
			{
				dispatchEvent(new CustomEvent(Event.COMPLETE));
			}
		}
		
		public function destroy():void
		{
			_mc.removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function get mc():MovieClip { return _mc; }
		
		public function get currentLabel():String { return _currentLabel; }
		
		public function get currentFrame():int { return _mc.currentFrame; }
		
		public function get totalFrames():int { return _mc.totalFrames;}
		
		
	}

}