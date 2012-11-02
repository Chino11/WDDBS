package com.dfp.view
{
	public class Preloader extends PreloaderBase
	{
		private var _percent:Number;
		
		public function Preloader()
		{
			super();
			Loader.scaleX = 0;
			tfLoadPercent.text = "0%";
		}
		
		
		public function get percent():Number
		{
			return _percent;
		}

		public function set percent(value:Number):void
		{
			_percent = value;
			Loader.scaleX = _percent;
			tfLoadPercent.text = uint(_percent*100) + "%";
		}

	}
}