package org.fatlib.display 
{
	import flash.display.Sprite;
	import org.fatlib.utils.DisplayUtils;
	
	public class WireframeButton extends Button
	{
		public function WireframeButton(buttonName:String, color:int= 0xFFFF88) 
		{
			super();
			name = buttonName;
			var b:Button = new Button();
			var up:Sprite = DisplayUtils.createRectangle(0, 0, 100, 20, color, true);
			up.addChild(new Text(buttonName));
			var over:Sprite = DisplayUtils.createRectangle(0, 0, 100, 20, 0x000000);
			over.addChild(new Text(buttonName, null, 0, false, color));
			registerState(Button.UP, up)
			registerState(Button.OVER, over);
		}
		
	}

}