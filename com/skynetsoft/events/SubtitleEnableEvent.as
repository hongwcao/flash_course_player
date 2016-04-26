package com.skynetsoft.events {
	import flash.events.Event;
	import flash.sampler.Sample;
	//字幕面板启用或关闭面板
	public class SubtitleEnableEvent extends Event {
        public static const ENABLE_STATUS:String ="subtitle_enable_status"; 
		private var _param:Boolean = true;
		public function getParam():Boolean{
			  return _param
			}
		public function setParam(ob:Boolean){
			  _param = ob;
			}	
		public function SubtitleEnableEvent(eventType:String) {
			super(eventType);
		}
	}
}
