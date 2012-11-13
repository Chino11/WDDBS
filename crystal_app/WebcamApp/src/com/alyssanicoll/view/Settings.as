package com.alyssanicoll.view{
	import com.alyssanicoll.events.SettingsEvent;
	import com.alyssanicoll.vo.SettingsVO;
	
	import fl.controls.ComboBox;
	
	import flash.events.Event;
	import flash.media.Camera;
	
	public class Settings extends SettingsBase{
		private var _inFront:Boolean = true;
		private var _settingsVO:SettingsVO = new SettingsVO();
		
		public function Settings(){
			super();
			
			this.frontCheckBox.addEventListener(Event.CHANGE,onUpFrontCheckBoxChange);
			this.resolutionDropDown.addEventListener(Event.CHANGE,onResChange);
			
			onAddingCameras();
			this.cameraDropDown.addEventListener(Event.CHANGE,onCamChange); 
		}
		
		private function onAddingCameras():void
		{
			var cameras:Array = Camera.names;
			for(var c:Number = 0; c<cameras.length; c++) {
				cameraDropDown.addItem( { label: cameras[c]} );
			}
			cameraDropDown.enabled = true;
		}
		
		private function onCamChange(event:Event):void
		{
//			trace(ComboBox(event.currentTarget).selectedLabel);
			_settingsVO.defaultCameraIndex = ComboBox(event.currentTarget).selectedIndex;
			
			dispatchEvent(new SettingsEvent(SettingsEvent.SETTINGS_CHANGE));
		}
		
		private function onResChange(event:Event):void{
			var dataArray:Array = ComboBox(event.currentTarget).selectedItem.data.split(",");
			_settingsVO.resolutionX = dataArray[0];
			_settingsVO.resolutionY = dataArray[1];
			
			_settingsVO.resolutionSelected = ComboBox(event.currentTarget).selectedIndex;
			
			dispatchEvent(new SettingsEvent(SettingsEvent.SETTINGS_CHANGE));
		}
		
		private function onUpFrontCheckBoxChange(event:Event):void{
			trace("Checkbox Selection:",frontCheckBox.selected);
			//_inFront = false;
			if(!this.frontCheckBox.selected){
				_inFront = true;
			}
			_settingsVO.inFront = frontCheckBox.selected;
			
			dispatchEvent(new SettingsEvent(SettingsEvent.SETTINGS_CHANGE));
		}
		
		public function get settingsVO():SettingsVO{
			return _settingsVO;
		}

		public function set settingsVO(value:SettingsVO):void{
			_settingsVO = value;
			//Set    selectedIndex here
			resolutionDropDown.selectedIndex = _settingsVO.resolutionSelected;
			cameraDropDown.selectedIndex = _settingsVO.defaultCameraIndex; //array index
			frontCheckBox.selected = _settingsVO.inFront;
		}
	}
}