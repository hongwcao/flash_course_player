package  {
    import flash.events.Event;
	import com.skynetsoft.util.Constant;
	//面板状态事件类
	public class PanelStatusEvent extends Event {
        public static const END:String=PanelStatusType.END;
		public static const READY:String=PanelStatusType.READY;
    	public static const COME:String=PanelStatusType.COME;
		public static const BACK:String=PanelStatusType.BACK;
		public static const HIDE:String=PanelStatusType.HIDE;
		public function PanelStatusEvent(eventType:String) {
			super(eventType);
		}

	}
	
}
