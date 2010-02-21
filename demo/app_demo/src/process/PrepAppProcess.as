package process 
{
	import org.fatlib.process.AsyncProcess;
	import org.fatlib.utils.Delay;
	import screen.*;

	public class PrepAppProcess extends AsyncProcess
	{
		
		private var _delay:Delay;
		
		override public function execute():void 
		{
			DemoApp.instance.screens.register('load', LoadingScreen);
			DemoApp.instance.screens.register('intro', IntroScreen);
			DemoApp.instance.screens.register('main', MainScreen);
			
			DemoApp.instance.screens.goto('load');
			_delay = new Delay();
			_delay.create(3000, loadingDone);
		}
		
		private function loadingDone():void 
		{
			_delay.destroy();
			done();
		}
	}

}