package com.skynetsoft.events {
	import flash.events.Event;
	import flash.sampler.Sample;

	public class SwitchButtonEvent extends Event {
        public static const ON_CHANGE:String ="switch_on_change"; 
		private var _param:String;
		public function getParam():String{
			  return _param
			}
		public function setParam(ob:String){
			  _param = ob;
			}	
		public function SwitchButtonEvent(eventType:String) {
			super(eventType);
			// constructor code
		}
		

	}
	
}
