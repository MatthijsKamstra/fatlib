package  
{
	import flash.display.Stage;
	import org.fatlib.app.AppBase;
	import org.fatlib.app.ScreenManager;
	import org.fatlib.process.Callback;
	import org.fatlib.process.MacroProcess;
	import process.LaunchAppProcess;
	import process.PrepAppProcess;

	public class DemoApp extends AppBase
	{
		public static const VERSION:String = '0.0.1';
		
		public static var instance:DemoApp;
		
		private var _screens:ScreenManager;
		
		public function DemoApp(stage:Stage) 
		{
			super(stage);
			instance = this;
			
			_screens = new ScreenManager();
			_display.addChild(_screens.display);
			
			var startUp:MacroProcess = new MacroProcess();
			startUp.addProcess(new PrepAppProcess());
			startUp.addProcess(new LaunchAppProcess());
			startUp.execute();
		}
		
		public function get screens():ScreenManager { return _screens; }
	}

}