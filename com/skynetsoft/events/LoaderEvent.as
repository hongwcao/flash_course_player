package com.skynetsoft.events {
	import flash.events.Event;
	import flash.sampler.Sample;
	
	public class LoaderEvent extends Event {
        public static const READY_FOR_PLAY:String = "ready_for_play";
		public static const LOAD_FOR_PLAY:String ="loading_for_play";
		public static const PAUSE:String="pause_for_playing";
		public static const REPLAY:String="replaying";
		public static const LESSON_STATUS_ONCHANGE="lesson_status_onchange";
		public static const LANGUAGE_ONCHANGE="language_onchange";
		private var _mediaType:String;
		private var _lessonStatus:String;
		private var _key:String;
		public function set key(k:String):void{
			  _key = k
			}
		public function get key():String{
			   return _key;
			}	
		public function set lessonStatus(s:String):void{
			  _lessonStatus = s;
			}
		public function get lessonStatus():String{
			  return _lessonStatus;
			}	
		public function setMediaType(_ob:String){
			   _mediaType = _ob;
			}
		public function getMediaType():String{
			   return _mediaType;
			}	
		public function LoaderEvent(evtType:String) {
			super(evtType);
		}

	}
	
}
