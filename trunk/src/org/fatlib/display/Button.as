package org.fatlib.display 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import org.fatlib.utils.Delay;
	
	/**
	 * A simple button based on the Graphic class.
	 * 
	 * Clients register UP, OVER and optionally DISABLED states to the button.
	 * The button listens to mouse events and automatically switches states
	 * 
	 * If no DISABLED state is defined, the UP state is shown at 30% alpha.
	 * 
	 */
	public class Button extends Graphic
	{
		public static const UP:String = 'up';
		public static const OVER:String = 'over';
		public static const DISABLED:String = 'disabled';
		
		/**
		 * This sound will be triggered on mouse over
		 */
		private var _overSound:Sound;
		
		/**
		 * This sound will be triggered after the mouse has hovered over the button for
		 * a certain length of time, defined by the _hoverTimeout property
		 */
		private var _hoverSound:Sound;
		private var _hoverSoundChannel:SoundChannel;
		private var _hoverTimeout:Number;
		private static var DEFAULT_HOVER_TIMEOUT:Number = 1000;
		
		/**
		 * This sound will be triggered on mouse down.
		 */
		private var _downSound:Sound;
		
		private var _delay:Delay;
		
		
		public function Button() 
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			addEventListener(MouseEvent.CLICK, onDown, false, 0, true);
			
			registerState(UP);
			registerState(OVER);
			
			childrenInteractable = false;
			interactable = true;
			actAsButton = true;
			
			_delay = new Delay();
						
		}
		
		public function set overSound(value:Sound):void 
		{
			_overSound = value;
		}
		
		public function set downSound(value:Sound):void 
		{
			_downSound = value;
		}
		
		public function set hoverSound(value:Sound):void 
		{
			_hoverSound = value;
		}
		
		override public function registerState(key:*, state:DisplayObject=null):void 
		{
			super.registerState(key, state);
			
			if (key == UP)
				showState(UP);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_delay.destroy();
		}
		
		///// PROTECTED
			
		override protected function handleMadeInteractive():void
		{
			alpha = 1;
			
			if (hasState(UP))
				showState(UP);
		}
		
		override protected function handleMadeNonInteractive():void
		{
			
			if (hasState(DISABLED))
			{
				showState(DISABLED);
			} else {
				showState(UP);
				alpha = 0.3;
			}
		}
		
		////////// PRIVATE
		
		private function onOver(e:MouseEvent):void 
		{
			showState(OVER);
			if (_overSound)_overSound.play();
			
			if (_hoverSound)
			{
				if (!_hoverTimeout)_hoverTimeout = DEFAULT_HOVER_TIMEOUT;
				_delay.create(_hoverTimeout, playHoverSound);
			}
		}
		
		private function playHoverSound():void 
		{
			_hoverSoundChannel = _hoverSound.play();
		}
		
		private function onOut(e:MouseEvent):void 
		{
			showState(UP);
		
			_delay.cancelAll();
			if (_hoverSoundChannel)
			{
				_hoverSoundChannel.stop();
				_hoverSoundChannel = null;
			}
		}
		
		private function onDown(e:MouseEvent):void 
		{
			if (_downSound)	_downSound.play();
		}
	}
}