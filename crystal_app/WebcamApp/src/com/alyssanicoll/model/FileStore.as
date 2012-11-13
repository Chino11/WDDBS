package com.alyssanicoll.model
{
	import com.alyssanicoll.view.Settings;
	import com.alyssanicoll.vo.SettingsVO;
	
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class FileStore extends EventDispatcher
	{
		
		private var _settings:Settings;
		private var _mainScreen:NativeWindow;
		private var _settingsVO:SettingsVO;
		public function FileStore(target:IEventDispatcher=null)
		{
			super(target);
			openSavedSettings();
		}
		
		// ACTUALLY listen on native window to close, that will call the onSave

		public function get settingsVO():SettingsVO
		{
			return _settingsVO;
		}

		public function set settingsVO(value:SettingsVO):void
		{
			_settingsVO = value;
			writeSavedSettings();
		}

		private function writeSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			_settingsVO.x = 0;
			_settingsVO.y = 0;
			_settingsVO.inFront;
			
			var fs:FileStream = new FileStream();
			
			fs.open(file,FileMode.WRITE);
			fs.writeObject(_settingsVO);
			fs.close();
			
		}
		
		// ACTUALLY call this function when the app opens
		private function openSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			if(! file.exists){
				trace("File Does not exist");
				// If the file doesn't exist, Perhaps populate a settings VO with default values.
				// OR bring up the settings menu so the user can define and save their own settings.
				return
			}
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			//pull vo back out and cast it as vo and then set the var throughout the doc = to its variables
			_settingsVO = fs.readObject() as SettingsVO;
			fs.close();
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
	}
}