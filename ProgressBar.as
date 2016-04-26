package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.skynetsoft.events.ProgressMouseEvent;
	import com.skynetsoft.events.ProgressBarEnableEvent;

    public class ProgressBar extends MovieClip {
		private var _progress:Progress = new Progress();
		private var _dragBtn:ProgressBarDragButton = new ProgressBarDragButton();
		private var _playBtn:PlayButton = new PlayButton();
		private var _pauseBtn:PauseButton = new PauseButton();
		private static var _ratioOfFP:Number;
		private var _contentOb:MovieClip = new MovieClip();
		
		public function set contentOb(ob:MovieClip):void{
			   _contentOb = ob;
			}
		public function get contentOb():MovieClip{
			  return _contentOb;
			}	
		private function getPauseBtn():PauseButton{
			   return _pauseBtn;
			}
		private function getPlayBtn():PlayButton{
			   return _playBtn;
			} 	
		
		//todo 解决ratioOfFP计算的性能问题
		private function setRatioOfFP(){
			
			}
		private function getRatioOfFP(){
			}	
		
		
		private function getProgress():Progress{
			   return _progress;
			}
		public function getDragBtn():ProgressBarDragButton{
			   return _dragBtn;
			}	
		private function isDrag():Boolean{
				return this._dragBtn.isDrag();
			 }
		private function regEvents(ob:ProgressBar){
			    ob.addEventListener(Event.ENTER_FRAME,onDragProgress);
				ob.addEventListener(MouseEvent.ROLL_OUT,onMouseRollOut);
				ob.addEventListener(MouseEvent.ROLL_OVER,onMouseRollOver);
				ob.getDragBtn().addEventListener(ProgressMouseEvent.CLICK,onProgressMouseEvent);
				ob.getProgress().addEventListener(ProgressMouseEvent.CLICK,onProgressMouseEvent);
				ob.getPauseBtn().addEventListener(MouseEvent.CLICK,onPauseMouseClick);
				ob.getPlayBtn().addEventListener(MouseEvent.CLICK,onPlayMouseClick)
		}
		private function onMouseRollOut(evt:MouseEvent){
				dispatchEvent(new ProgressMouseEvent(ProgressMouseEvent.MOUSE_OUT));
			}
		private function onMouseRollOver(evt:MouseEvent){
			    dispatchEvent(new ProgressMouseEvent(ProgressMouseEvent.MOUSE_OVER));
			}	
		private function onPauseMouseClick(evt:MouseEvent){
			     evt.stopImmediatePropagation();
				 raisePauseEvent(); 
			}
		public function raisePauseEvent():void{
			    var pauseBtnClick:ProgressMouseEvent = new ProgressMouseEvent(ProgressMouseEvent.PAUSE_BUTTON_CLICK);
				dispatchEvent(pauseBtnClick);
				this.getPauseBtn().visible = false;
				this.getPlayBtn().visible = true;
			}	
		private function onPlayMouseClick(evt:MouseEvent){
			     evt.stopImmediatePropagation()
                 raiseReplayEvent();
			}	
		public function raiseReplayEvent():void{
				 var playBtnClick:ProgressMouseEvent = new ProgressMouseEvent(ProgressMouseEvent.PLAY_BUTTON_CLICK);
				 dispatchEvent(playBtnClick);
				 this.getPlayBtn().visible = false;
				 this.getPauseBtn().visible = true;
			}	
		
		private function onProgressMouseEvent(evt:ProgressMouseEvent){
			   evt.stopImmediatePropagation();
			   this.getDragBtn().setIsDrag(false);
			   
			}
		
		//拖拽进度条控制按钮的处理函数
		private function onDragProgress(evt:Event){
				//定义载入内容的对象
				var _content:MovieClip =  this.contentOb;        
				//evt.currentTarget.parent as MovieClip;
				//定义载入内容的当前帧数
                var _currentFrame:uint = _content.currentFrame;
				//定义载入内容的全部帧数
				var _totalFrames:uint = _content.totalFrames;
				//定义播放进度条的对象
				var _progressBar:ProgressBar = evt.currentTarget as ProgressBar;
				//定义播放进度条对象的长度
				var _progressWidth:uint = _progressBar.getDragBtn().getProgressWidth();
				//定义内容总帧数与进度条长度的比率
				var ratioOfFP:Number = Math.round((_totalFrames/_progressWidth)*100)*0.01;
				//定义计算帧号
				var _x:Number;
				
				//如果拖拽按钮没有使用，则播放进度条由载入的内容对象来控制
				if (!isDrag()) {
				this.getDragBtn().autoMoveBtn(_currentFrame,_totalFrames);
				} 
				//如果拖拽按钮应用了，则播放进度条进行内容对象的控制
				else if (isDrag()){
				   //预处理 鼠标位置向前偏移的问题
				   var mouse_x:Number;
				   if  (this.mouseX < 0 ){
					     mouse_x = 0;
					   } 
				    else if (this.mouseX >=0 ){
						 mouse_x = this.mouseX;
					}
				   //trace("trace mouseX is " + mouse_x);
				   //var _x:Number = Math.floor((Math.abs(mouse_x))*(_totalFrames/_progressWidth)); 
				   _x = Math.floor(mouse_x * ratioOfFP);
				   //后处理 鼠标位置向后偏移的问题
				   if (_x > _totalFrames) {
					     _x = _totalFrames
					   }
				   var mouseClick:ProgressMouseEvent = new ProgressMouseEvent(ProgressMouseEvent.CLICK);
				   //trace(_x);
				   mouseClick.setStageX(_x);
				   evt.stopImmediatePropagation();
				   dispatchEvent(mouseClick);
				}
			}
		
		//暂不实现
		private function onMouseOutOfBar(evt:MouseEvent){
			    //trace(Date.UTC+" mouse out of bar!");
			}	
		public function onProgressBarEnable(evt:ProgressBarEnableEvent):void{
			   trace("progressBarEnable enabled");
			   this.addEventListener(Event.ENTER_FRAME,onDragProgress);
			   this.addEventListener(MouseEvent.ROLL_OUT,onMouseRollOut);
			   this.addEventListener(MouseEvent.ROLL_OVER,onMouseRollOver);
			   this.visible = true;
			   evt.stopImmediatePropagation();
			}	
		public function onProgressBarDisable(evt:ProgressBarEnableEvent):void{
			   trace("progressBarEnable disabled");
			   this.removeEventListener(Event.ENTER_FRAME,onDragProgress)
			   this.removeEventListener(MouseEvent.ROLL_OUT,onMouseRollOut);
			   this.removeEventListener(MouseEvent.ROLL_OVER,onMouseRollOver);
			   this.visible = false;
			   evt.stopImmediatePropagation();
			}	
		
		public function ProgressBar() {
			//this.x = 96.8;
			//this.y = 652.05;
			this.x = 96.8;
			this.y = 650.00;
			name = "progress bar";
			//this.y = 600.00;
			regEvents(this);
			this.getProgress().mask = this.getDragBtn().getMaskOfProgress();
			addChild(getProgress());
			addChild(getDragBtn());
			addChild(getPauseBtn());
			addChild(getPlayBtn());
			//this.visible = false;
			this.visible = true;
			this.alpha = 0;
		}
	}
}
