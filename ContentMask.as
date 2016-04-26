package  {
	
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import com.skynetsoft.util.Constant;
	import flash.events.Event;
	import fl.transitions.TweenEvent;
	import com.skynetsoft.util.GlobalDialogHandler;
	import com.skynetsoft.util.Dialog;
	
	//内容容器的遮罩类，用于控制内容容器遮罩层显示的alpha值
	public class ContentMask extends MovieClip {
		
		/*private static var _stack:Array = new Array();
		private static function popStack():Boolean{
			   _stack.pop();
			   if (_stack.length > 0) { 
                  return true;
			   } else {
				  return false;
				 }
			}
		private static function pushStack():void{
			   _stack.push("panel x"); 
			}
		private static function isStackEmpty():Boolean{
			  if (_stack.length <= 0) {
				    return true;
				  } else {
					  return false;
					  }
			}	*/
		
		//构造函数
		public function ContentMask() {
			this.x = 0;
			this.y = 50;
			this.alpha =0;
			this.visible = false;
		}
		//遮罩alpha值缓动的执行函数	
		public function onExecute(evt:PanelStatusEvent):void
		{
			var tween:Tween;
			this.visible = true;
			//判断触发事件是否为COME
			if (evt.type == PanelStatusType.COME){ 
			      //if (isStackEmpty()) {
				  //判断当前的对话框堆栈是否为空，如果是空则执行显示缓动动画，并将当前的对话框压入堆栈	  
				  if (GlobalDialogHandler.isStackEmpty()){	  
						tween = doMotionStart();
						//GlobalDialogHandler.pushStack(evt.currentTarget as Dialog);
						//pushStack();
						tween.start();
					  }
            }
			//判断触发事件是否为BACK
			else if (evt.type == PanelStatusType.BACK ){
				  //if (!popStack()) {
				  //GlobalDialogHandler.popStack();
				  //判断当前的对话框堆栈出栈的是否为最后一个对话框对象，是则执行隐藏缓动动画
				  if (GlobalDialogHandler.isStackEmpty()){	   	  
					     tween = doMotionEnd();
						 tween.start();
					  } 
				}	
		}//end execute()
		
/*		public  function hideDialogs(evt:PanelStatusEvent):void{
			   if (_stack.length > 1) {
			      popStack();
			   }
			}*/
		private function doMotionStart():Tween{
			   var ob:Tween;
			   ob = new Tween(this,"alpha",None.easeOut,0,Constant.MASK_ALPHA_FINAL,Constant.MOTION_DIALOG_SPEED,true);
			   ob.stop();
        	   //ob.addEventListener(TweenEvent.MOTION_START,onPanelReadyStart);
			   //ob.addEventListener(TweenEvent.MOTION_FINISH,onPanelStatusEnd);
			   return ob;
			}
		private function doMotionEnd():Tween{
               var ob:Tween;
			   ob = new Tween(this,"alpha",None.easeOut,Constant.MASK_ALPHA_FINAL,0,Constant.MOTION_DIALOG_SPEED,true);   
			   ob.stop();
			   //ob.addEventListener(TweenEvent.MOTION_START,onPanelEndStart);
			   //ob.addEventListener(TweenEvent.MOTION_FINISH,onPanelStatusReady);
			   this.visible =false;
			   return ob;
			}

	}
	
}
