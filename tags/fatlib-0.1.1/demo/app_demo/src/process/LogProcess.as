package process 
{
	import org.fatlib.Fatlib;
	import org.fatlib.Log;
	import org.fatlib.process.SyncProcess;

	public class LogProcess extends SyncProcess
	{
		override public function execute():void 
		{
			Log.log(Fatlib.VERSION);
		}
	}

}