package com.dfp.view
{
	import com.mapquest.tilemap.overlays.ImageOverlay;
	import com.mapquest.tilemap.overlays.RectangleOverlay;
	
	public class IOView extends ImageOverlay
	{
		private var _path:String;
		private var _tooltip:String;
		private var _start:String;
		private var _end:String;
		
		public function IOView(overlayToCopy:RectangleOverlay=null)
		{
			super(overlayToCopy);
		}

		public function get path():String
		{
			return _path;
		}

		public function set path(value:String):void
		{
			_path = value;
		}

		public function get tooltip():String
		{
			return _tooltip;
		}

		public function set tooltip(value:String):void
		{
			_tooltip = value;
		}

		public function get start():String
		{
			return _start;
		}

		public function set start(value:String):void
		{
			_start = value;
		}

		public function get end():String
		{
			return _end;
		}

		public function set end(value:String):void
		{
			_end = value;
		}


	}
}