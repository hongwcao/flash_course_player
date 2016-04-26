package  {
	
	import flash.display.MovieClip;
	import com.skynetsoft.util.AcronymsCompleted;
	import com.skynetsoft.util.Constant;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import fl.events.ComponentEvent;
	import flash.sensors.Accelerometer;
	import fl.transitions.TweenEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import com.skynetsoft.util.Dialog;
	
	public class AcronymsDialog extends Dialog{
		
		private var _autoCompleteField:AcronymsCompleted;
		private var _scrollText:TextField;
		private var closeBtn:CloseBtn;
		
		private function getAcronymsXML():XML{
			  return _autoCompleteField.getData();
			}
		
		private function getTextFormat():TextFormat{
			 var _fmt = new TextFormat();
             //常用样式
             _fmt.align = "left";
             //my_fmt.blockIndent = 50; //区块缩进
             //my_fmt.bold = true;
             //my_fmt.bullet = true;
             _fmt.color = 0xffffff;
             _fmt.font = "微软雅黑";
             //my_fmt.indent = 50; //首字缩进
             //my_fmt.italic = true;
             _fmt.kerning = true; //字距调整
             _fmt.leading = 2; //行距
             //my_fmt.letterSpacing = 10; //字间距
             //my_fmt.leftMargin = 10;
             //my_fmt.rightMargin = 10;
             _fmt.size = 20;
             //my_fmt.underline = true;
             //my_fmt.target = "blank"
			 return _fmt;
			}
		public function setScrollText(ob:String){
			  _scrollText.text = ob;
			}	
		
		private function registerEvents(ob:AcronymsDialog) {
			   //ob.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownDrag);
			   //ob.addEventListener(MouseEvent.MOUSE_UP,onMouseUpDrag);
			   ob._autoCompleteField.addEventListener(AutoCompleteEvent.FINISH,onInputFinish);
			   closeBtn.addEventListener(MouseEvent.CLICK,onExecute);
			}

/*		private function onMouseDownDrag(evt:MouseEvent){
			   (AcronymsDialog)(evt.target).startDrag();
			}
		private function onMouseUpDrag(evt:MouseEvent){
			   (AcronymsDialog)(evt.target).stopDrag();
			}*/
		private function onInputFinish(evt:AutoCompleteEvent){
			   getAcronymsText(getAcronymsXML(),evt.getInputText());
			}	
			
		private function getAcronymsText(_xml:XML,_input:String){
			  var _output:XMLList = _xml.*.(acronym.toUpperCase() == _input.toUpperCase());
			  if (_output.length() == 1) {
				    setTextField(_output.acronym,_output.details,_output.en,_output.cn); 
				  }
			}	
		private function setTextField(..._ops){
			   if (_ops.length > 0) {
				     this._scrollText.text = "";
					 for (var i:uint = 0 ; i <= _ops.length-1 ; i++){
						    this._scrollText.appendText(_ops[i]+"\n\r");
						 }
					 this._scrollText.setTextFormat(getTextFormat());	 
				   }
			}	
		private function initTextField(){
                _scrollText = new TextField();
				this._scrollText.mouseEnabled = false;
				this._scrollText.wordWrap = true;
				this._scrollText.x = 12;
				this._scrollText.y = 92.45;
				this._scrollText.width = 426;
				this._scrollText.height =  300;
				this._scrollText.type = TextFieldType.INPUT;
				this._scrollText.setTextFormat(getTextFormat());
				this.addChild(_scrollText);
			}
		public function AcronymsDialog() {
			// constructor code
			this.x = 130.75;
			this.y = 261.8;
			this.visible = false;
			this.alpha = 0;
			_autoCompleteField = new AcronymsCompleted();
			addChild(_autoCompleteField);
			this.filters = new Array(Constant.getDefaultDropShadow());
			initTextField();
			closeBtn = new CloseBtn();
			closeBtn.x =420;
			closeBtn.y = 10;
			registerEvents(this);
			addChild(closeBtn);
			this.setDragable(true);
		}
	}//end class
}//end package
