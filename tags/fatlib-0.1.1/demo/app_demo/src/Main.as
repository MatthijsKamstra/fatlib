package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.fatlib.app.AppBase;
	import org.fatlib.display.LayoutManager;
	import org.fatlib.display.Text;
	import org.fatlib.events.TextInputEvent;
	
	public class Main extends Sprite 
	{
		public function Main():void 
		{
			var a:AppBase = new DemoApp(this.stage);
		}
	}
}