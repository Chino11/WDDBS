package com.alyssanicoll.view
{
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;

	public class Filters
	{
		private var _myBlur:BlurFilter;
		private var _myGlow:GlowFilter;
		
		public function Filters()
		{
			
			_myBlur = new BlurFilter();
			_myBlur.quality = 5;
			_myBlur.blurX = 10;
			_myBlur.blurY = 10;
			
			_myGlow = new GlowFilter(); 
			_myGlow.inner = true; 
			_myGlow.alpha = .8;
			_myGlow.color = 0x1a1a1a; 
			_myGlow.blurX = 1000; 
			_myGlow.blurY = 1000;
			
		}

		public function get myGlow():GlowFilter
		{
			return _myGlow;
		}

		public function get myBlur():BlurFilter
		{
			return _myBlur;
		}

		
		// we have to have an instance of this Filters Class in the class thats getting these filters or
		// we can make public static constants that can be accessed directly from the Filters class
	}
}