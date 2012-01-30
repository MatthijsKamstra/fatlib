package org.fatlib.media 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import org.fatlib.interfaces.IProcess;
	import org.fatlib.Log;
	import org.fatlib.process.Callback;

	public class SimpleSoundManager
	{
		
		private var _muted:Boolean = false;
		private var _loop:SoundChannel;
		
		private var _sounds:Dictionary;
		
		public var factory:Function;
		
		public function SimpleSoundManager(factory:Function = null) 
		{
			Log.log('[SimpleSoundManager]');
			this.factory = factory;
			_sounds = new Dictionary();
		}
		
		public function triggerSound(linkageID:String, onComplete:Function = null, onCompleteParams:Array = null, volume:Number = 1):void
		{
			if (factory == null) throw(new Error("Define a factory function first. Should look like this: function(linkageID:String):Sound"));
			Log.log("[SimpleSoundManager] playing sound "+linkageID);
			
			try
			{
				var s:Sound = factory(linkageID);
			} catch (e:Error)
			{
				Log.log("[SimpleSoundManager] Couldn't find sound '" + linkageID + "'");
				if (onComplete != null)	new Callback(onComplete, onCompleteParams).execute();
				return;
			}
			var c:SoundChannel = s.play(0, 0, new SoundTransform(volume));

			if (onComplete != null)
			{
				var o:Object = { channel:c }
				o['callback'] = new Callback(onComplete, onCompleteParams);
				_sounds[c] = o;
				c.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
		}
		
		public function triggerSoundThenLoop(soundID:String, loopID:String):void
		{
			triggerSound(soundID, playLoop, [loopID]);
		}
		
		private function onSoundComplete(e:Event):void 
		{
			var c:SoundChannel = e.target as SoundChannel;
			c.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			var callback:Callback = _sounds[c]['callback'];
			delete _sounds[c];
			if (callback) callback.execute();
		}
		
		public function playLoop(linkageID:String, volume:Number = 1):void
		{
			if (factory == null) throw(new Error("Define a factory function first. Should look like this: function(linkageID:String):Sound"));
			stopLoop();
			try
			{
				var s:Sound = factory(linkageID);
			} catch (e:Error)
			{
				Log.log("[SimpleSoundManager] Couldn't find loop '" + linkageID + "'");
				return;
			}
			_loop=s.play(0, 9999, new SoundTransform(volume));
		}
		
		// cancels callbacks and stops music
		public function cleanUpScreenSounds():void
		{
			for (var s:* in _sounds)
			{
				var c:SoundChannel = _sounds[s]['channel'];
				c.stop();
				c.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				delete _sounds[s];
			}
			stopLoop();
		}
		
		public function stopLoop():void
		{
			if (_loop)_loop.stop();
			_loop = null;
		}
		
		////////
		
		public function mute():void
		{
			_muted = true;
			SoundMixer.soundTransform = new SoundTransform(0);
		}
		
		public function unmute():void
		{
			_muted = false;
			SoundMixer.soundTransform = new SoundTransform(1);
		}
		
		public function get muted():Boolean { return _muted; }
		
		public function set muted(value:Boolean):void 
		{
			_muted = value;
			if (_muted)
			{
				mute();
			} else {
				unmute();
			}
		}
		
		public function toggleMute():void
		{
			muted = !muted;
		}
		
	}

}