package screen 
{
	import org.fatlib.app.Screen;
	import org.fatlib.display.Text;
	import org.fatlib.display.WireframeButton;
	import org.fatlib.Fatlib;
	
	public class MainScreen extends Screen
	{
		
		public function MainScreen() 
		{
			super();
		}
		
		override public function handleAdded():void 
		{
			_canvas.addChild(new Text('Main screen'));
			_canvas.addChild(new Text('fatlib version ' + Fatlib.VERSION)).y = 20;
			_canvas.addChild(new WireframeButton('intro')).y = 50;
			
		}
		
		override protected function handleClicked(targetName:String):void 
		{
			gotoScreen(targetName);
		}
		
		
		
	}

}