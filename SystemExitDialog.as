package  {
	
	import com.skynetsoft.util.Constant;
	import com.skynetsoft.util.Dialog;
	
	//退出对话框类
	public class SystemExitDialog extends Dialog {
        //声明面板状态对象
		private var _panelStatus:String;				
		private function setPanelStatus(ob:String){
			  _panelStatus = ob;
			}
		private function getPanelStatus():String {
			   return _panelStatus;
			}
		//构造函数
		public function SystemExitDialog() {
			this.visible = false;
			this.alpha = 0;
			this.x = 247;
			this.y = 260;
			this.filters = new Array(Constant.getDefaultDropShadow());
			this.setDragable(true);
		}
		
	}//class
}//package
