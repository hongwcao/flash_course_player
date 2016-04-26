package com.skynetsoft.events {
	import flash.events.Event
	public class ProgressBarEnableEvent extends Event{
        public static const ENABLE:String ="PROGRESS_BAR_ENABLE";
		public static const DISABLE:String ="PROGRESS_BAR_DISABLE";
		public function ProgressBarEnableEvent(evtType:String) {
			super(evtType);
		}

	}
}
