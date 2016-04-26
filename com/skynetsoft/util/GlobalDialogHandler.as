package com.skynetsoft.util {
	import com.skynetsoft.util.Dialog;
	//全局对话框处理类,用于处理未关闭前，当前有多少对话框处于弹出状态，并以堆栈的方式进行存放。
	public class GlobalDialogHandler {
		private static var _stackDialog:Array = new Array();
		
		public static function popStack():Dialog{
			   if (_stackDialog.length <= 0) {
				      return null
				   } else {
			          return _stackDialog.pop()
				   }
			}
		public static function pushStack(_dialog:Dialog):void{
			   _stackDialog.push(_dialog); 
			}
		
		public static function isStackEmpty():Boolean{
			  if (_stackDialog.length <= 0) {
				    return true;
				  } else {
					  return false;
					  }
			}	
		public static function stackLength():uint{
			  return _stackDialog.length;
			}	
		
		//构造函数
		public function GlobalEventHandler() {
			// constructor code
		}
		//处理对话框弹出时,背景的灰度设定的处理方式
		/*public static function onExecute(_dialog:Dialog){
			 trace("stack empty status is "+isStackEmpty());
			 if (!isStackEmpty()){
				    var _popOb:Dialog = (popStack() as Dialog);
					if (_popOb != null) {
						   _popOb.hideDialogs(true);
						}
				 } 
			  //将对话框压入堆栈
			  pushStack(_dialog);   
		}//end onExecute function */
	}//end class
}//end package 
