package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class CompleteProgress extends MovieClip {
        private var _completed:TextField = new TextField();
		private var _fmt:TextFormat = new TextFormat();
		private function setCompleted(ob:TextField){
			   _completed = ob;
			}
		private function getCompleted():TextField{
			   return _completed;
			}	
		private function initCompleted(ob:TextField){
			  ob.x = 0;
			  ob.y = 0;
			  ob.height = 29.45;
			  ob.width = 39;
			  ob.text = "---";
			  ob.type = flash.text.TextFieldType.INPUT;
			  ob.mouseEnabled = false;
			  setCompleted(ob);
			}
		private function getTextFormat():TextFormat{
			  _fmt.align = flash.text.TextFormatAlign.RIGHT;
    		  _fmt.color = 0x00cc33;
			  _fmt.font = "Microsoft Tai Le";
			  _fmt.size = 20;
			  _fmt.bold = true;
			  return _fmt;
		}	
		private function setCompletedText(ob:String){
			  getCompleted().text = ob;
			}	
		public function onCompletedProgressCalculated(_evt:CategoryEvent){
			   setCompletedText(_evt.getCompletedProcess());
			   getCompleted().setTextFormat(getTextFormat());
			}	
		public function CompleteProgress(){
			this.x = 949.35;
			this.y = 12.3;
			initCompleted(getCompleted());
            getCompleted().setTextFormat(getTextFormat());
    		addChild(getCompleted());
		}
	}
	
}
