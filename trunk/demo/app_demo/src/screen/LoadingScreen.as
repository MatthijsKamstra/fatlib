package screen 
{
	import org.fatlib.app.Screen;
	import org.fatlib.display.Text;

	public class LoadingScreen extends Screen
	{
		
		public function LoadingScreen() 
		{
			super();
		}
		
		override public function handleAdded():void 
		{
			_canvas.addChild(new Text('Loading...'));
		}
		
	}

}