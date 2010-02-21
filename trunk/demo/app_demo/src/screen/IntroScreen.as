package screen 
{
	import org.fatlib.app.Screen;
	import org.fatlib.display.Text;
	import org.fatlib.display.WireframeButton;
	import org.fatlib.Fatlib;
	
	public class IntroScreen extends Screen
	{
		
		public function IntroScreen() 
		{
			super();
		}
		
		override public function handleAdded():void 
		{
			_display.addChild(new Text('Intro screen'));
			_display.addChild(new WireframeButton('main')).y = 30;
		}
		
		override protected function handleClicked(targetName:String):void 
		{
			gotoScreen(targetName);
		}
		
		
		
	}

}