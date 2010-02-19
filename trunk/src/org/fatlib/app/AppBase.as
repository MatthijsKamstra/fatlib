package org.fatlib.app
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import org.fatlib.utils.NetUtils;
	
	import org.fatlib.assets.AssetBank;
	import org.fatlib.display.Graphic;
	
	public class AppBase
	{
		protected var _screens:ScreenManager;
		protected var _flashvars:Object;
		protected var _assets:AssetBank;
		protected var _config:Config;
		
		public function AppBase(stage:Stage) 
		{
			_flashvars = NetUtils.getFlashVars(stage);
			_assets = new AssetBank();
			_screens = new ScreenManager();
			stage.addChild(_screens);
			_config = new Config();
		}
					
		public function get screens():ScreenManager { return _screens; }
		public function get assets():AssetBank { return _assets; }
		public function get flashvars():Object { return _flashvars; }
		public function get config():Config { return _config; }
		
	}
}