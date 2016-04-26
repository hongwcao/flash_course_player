package com.skynetsoft.util {
	import flash.events.MouseEvent;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.None;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import com.skynetsoft.util.Constant;
	import com.skynetsoft.events.LoaderEvent;
	import com.skynetsoft.util.GlobalDialogHandler;
    
	//对话框类，用于处理对话框的弹出及关闭以及相应的其他事件
	public class Dialog extends MovieClip{
		public var _tw:Tween;
		public function Dialog() {
			this.visible = false;
			this.filters = new Array(Constant.getDefaultDropShadow());
		}
		//直接隐藏对话框
		public function hideDialogs(_ob:Boolean=true){
			 this.visible = !_ob;
			}
        
		//对话框执行函数,对外部公布由继承的子类来执行
		public function onExecute(evt:MouseEvent){
			//判断当前对话框是否可见状态为false，是则打开对话框.
	        if (this.visible == false) {
				this.visible = true;
				//判断对话框堆栈中是否为空，如果为空则停止当前的播放操作，并启动背景缓动动画
				if (GlobalDialogHandler.isStackEmpty()) {
					//停止当前播放操作
					onShow();
					//启动对话框缓动动画,并触发背景缓动动画事件
					doMotionStart(true);
					} 
					//对话框堆栈不为空, 则将堆栈中的对话框出栈,并且设定该对话框的visible属性为false
					else {
					(GlobalDialogHandler.popStack() as Dialog).hideDialogs(true);
					//启动对话框缓动动画,但不触发背景缓动动画事件
					doMotionStart(false);
					}
				//将当前的对话框压入堆栈
				GlobalDialogHandler.pushStack(this);
				} 
	         //判断当前对话框如的可见状态是否为true，是则关闭对话框.
	         else if (this.visible == true) {
				//将当前的对话框出栈
				GlobalDialogHandler.popStack();
				//如果堆栈为空,启动对话框关闭缓动动画及背景关闭缓动动画，并继续进行播放操作
				if (GlobalDialogHandler.isStackEmpty()) {
					   doMotionEnd(true);
					   onHide();
					} else {
				       //如果堆栈不为空,则仅启动对话框关闭缓动动画,但不启动背景缓动动画，也不继续任何播放操作
					   doMotionEnd(false);
				}
			 } 
			}

		//对话框显示缓动动画
		public function doMotionStart(_ob:Boolean){
			  //var tw:Tween;
			  _tw = new Tween(this,"alpha",None.easeOut,0,1,Constant.MOTION_DIALOG_SPEED,true);
		      _tw.stop();
		      //如果_ob为true,则显示缓动动画启动同时,启动背景缓动动画
		      if (_ob == true) {
			     _tw.addEventListener(TweenEvent.MOTION_START,onDialogMotionCome);
			     }
			  _tw.start();
			}
		//对话框隐藏缓动动画	
		public function doMotionEnd(_ob:Boolean){
			  //var tw:Tween;
			  _tw = new Tween(this,"alpha",None.easeOut,1,0,Constant.MOTION_DIALOG_SPEED,true);
		      _tw.stop();
			  _tw.addEventListener(TweenEvent.MOTION_FINISH,onDialogMotionFinish);
			  ////如果_ob为true,则隐藏缓动动画启动同时,启动背景缓动动画
			  if (_ob == true) {
			      _tw.addEventListener(TweenEvent.MOTION_START,onDialogMotionBack);
			      }
			  _tw.start();
			}	
		
		//派发对话框缓动动画开始事件
		public function onDialogMotionCome(event:TweenEvent){
				dispatchEvent(new PanelStatusEvent(PanelStatusEvent.COME));
				event.stopImmediatePropagation();
				}
		public function onDialogMotionBack(event:TweenEvent){
				dispatchEvent(new PanelStatusEvent(PanelStatusEvent.BACK));
				event.stopImmediatePropagation();
				}
		//相应缓动动画结束事件	
		public function onDialogMotionFinish(event:TweenEvent){
				this.visible = false;
				event.stopImmediatePropagation();
				}
		//通知内容及语音播放暂停
		public function onShow(){
				dispatchEvent(new PanelStatusEvent(PanelStatusEvent.READY));
			}		
		//通知内容及语音播放继续
		public function onHide(){
				dispatchEvent(new PanelStatusEvent(PanelStatusEvent.END));
			}	
			
     	protected function setDragable(b:Boolean):void{
			   if (b == true) {
				      regDragEvents(this);
				   }
			}
		protected function regDragEvents(ob:Dialog) {
			   ob.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownDrag);
			   ob.addEventListener(MouseEvent.MOUSE_UP,onMouseUpDrag);
			}
		protected function onMouseDownDrag(evt:MouseEvent){
			   ((evt.target) as Dialog).startDrag();
			}
		protected function onMouseUpDrag(evt:MouseEvent){
			   ((evt.target) as Dialog).stopDrag();
			}	
	}
	
}
