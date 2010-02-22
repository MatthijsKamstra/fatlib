package process 
{
	import org.fatlib.process.SyncProcess;
	
	public class LaunchAppProcess extends SyncProcess
	{
		override public function execute():void 
		{
			DemoApp.instance.screens.goto('intro');
		}
	}
}