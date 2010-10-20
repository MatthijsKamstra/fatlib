package org.fatlib.display 
{
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import org.fatlib.utils.Delay;
	
	public class AudioButtonBase extends Graphic
	{
		
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
		
		private var _delay:Delay;
		
		/**
		 * This sound will be triggered on mouse down.
		 */
		private var _downSound:Sound;
		
		public function AudioButtonBase() 
		{
			super();
			_delay = new Delay();
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
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
		
		////////////
				
		private function onOut(e:MouseEvent):void 
		{
			_delay.cancelAll();
			if (_hoverSoundChannel)
			{
				_hoverSoundChannel.stop();
				_hoverSoundChannel = null;
			}
		}
		
		private function onOver(e:MouseEvent):void 
		{
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
		
		private function onDown(e:MouseEvent):void 
		{
			if (_downSound)	_downSound.play();
		}
		
		override public function destroy():void 
		{
			_delay.destroy();
			super.destroy();
		}
		
	}

}