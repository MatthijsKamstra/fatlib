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
			_display.addChild(new Text('Main screen'));
			_display.addChild(new Text('fatlib version ' + Fatlib.VERSION)).y = 20;
			_display.addChild(new WireframeButton('intro')).y = 50;
			_display.addChild(new WireframeButton('log')).y = 70;
			
		}
		
		override protected function handleClicked(targetName:String):void 
		{
			switch(targetName)
			{
				case 'intro':
					gotoScreen('intro');
					break;
				case 'log':
					DemoApp.instance.processes.trigger('log');
					break;
			}
		}
		
		
		
	}

}