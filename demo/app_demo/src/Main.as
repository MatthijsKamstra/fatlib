package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.fatlib.app.AppBase;
	import org.fatlib.display.LayoutManager;
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			var a:AppBase = new DemoApp(this.stage);
		}
		
	}
	
}