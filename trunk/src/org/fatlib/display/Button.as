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
		
		
		public function Button() 
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			
			registerState(UP);
			registerState(OVER);
									
			childrenInteractable = false;
			interactable = true;
			actAsButton = true;
						
		}
		
		override public function registerState(key:*, state:DisplayObject=null):void 
		{
			super.registerState(key, state);
			
			if (key == UP)
				showState(UP);
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
		}
		

		private function onOut(e:MouseEvent):void 
		{
			showState(UP);
		}
		

	}
}