package org.fatlib.ui 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.iterators.ChildIterator;
	import org.fatlib.utils.DisplayUtils;
	/**
	 * ...
	 * @author 
	 */
	public class StackButton 
	{
		private var _mc:MovieClip;
		private var _enabled:Boolean;
		private var _selected:Boolean;
		private var _over:Boolean;
		
		public function StackButton(mc:MovieClip) 
		{
			_mc = mc;
			if (!_mc['up']) throw new Error('button needs an up state');
			_mc.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			
			
			_mc.addEventListener(MouseEvent.MOUSE_OVER, onMouse);
			_mc.addEventListener(MouseEvent.MOUSE_OUT, onMouse);
			_mc.addEventListener(MouseEvent.CLICK, onMouse);
			_mc.mouseChildren = false;
			
			if (_mc['hit'])
			{
				_mc.hitArea = _mc['hit'];
				_mc['hit'].alpha = 0;
			} else {
				_mc.hitArea = _mc['up'];
			}
			
			var it:IIterator = new ChildIterator(_mc);
			while (it.hasNext)
			{
				var c:InteractiveObject = it.next;
				if (c.name != 'hit')
				{
					c.mouseEnabled = false;
				}
			}
			
			enable(true);
		}
		
		public function select(selected:Boolean):void
		{
			_selected = selected;
			
			_mc.buttonMode = !selected;
			_mc.useHandCursor = !selected;
			
			if (_selected)
			{
				setState('selected');
			} else {
				if (_over)
				{
					setState('over');
				} else {
					setState('up');
				}
			}
		}
		
		public function enable(enabled:Boolean):void
		{
			_enabled = enabled;
			
			_mc.buttonMode = enabled;
			_mc.useHandCursor = enabled;
			if (_enabled)
			{
				if (_over)
				{
					setState('over');
				} else {
					setState('up');
				}
			} else {
				setState('disabled');
			}
		}
		
		private function onMouse(e:MouseEvent):void 
		{
			
			switch(e.type)
			{
				case MouseEvent.MOUSE_OVER:
					_over = true;
					break;
				case MouseEvent.MOUSE_OUT:
					_over = false;
					break;
			}
			
			if (!_enabled || _selected) return;
		
			switch(e.type)
			{
				case MouseEvent.MOUSE_OVER:
					setState('over');
					break;
				case MouseEvent.MOUSE_OUT:
					setState('up');
					break;
			}
		}
		
		private function setState(state:String):void
		{
			if (!_mc[state]) return;
			var it:IIterator = new ChildIterator(_mc);
			while (it.hasNext)
			{
				var c:DisplayObject = it.next;
				if (c.name == state)
				{
					c.visible = true;
					if (c is MovieClip) MovieClip(c).gotoAndPlay(1);
				} else if (c.name != 'hit')
				{
					c.visible = false;
				}
			}
		}
		
		private function onRemoved(e:Event):void 
		{
			_mc.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			_mc.removeEventListener(MouseEvent.MOUSE_OVER, onMouse);
			_mc.removeEventListener(MouseEvent.MOUSE_OUT, onMouse);
		}
		
		
	}

}