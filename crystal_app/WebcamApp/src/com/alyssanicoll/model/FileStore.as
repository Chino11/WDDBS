package com.alyssanicoll.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.alyssanicoll.view.Settings;
	import flash.display.NativeWindow;
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	
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
		private function writeSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			_settingsVO.x = _mainScreen.x;
			_settingsVO.y = _mainScreen.y;
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
				_settingsVO = new SettingsVO();
				addSettings();
				return
			}
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			trace(fs.bytesAvailable);
			//pull vo back out and cast it as vo and then set the var throughout the doc = to its variables
			_settingsVO = fs.readObject();
			fs.close();
			
			trace("file Data: ",_settingsVO); // figure out how to see the object you saved to the file stream
			
		}
	}
}