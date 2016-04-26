package  {
	import com.skynetsoft.util.Constant;
	import com.skynetsoft.util.LanguageType;
	import com.skynetsoft.util.Dialog;
	import com.skynetsoft.events.SwitchButtonEvent;
	import com.skynetsoft.util.SwitchType;
	import flash.events.MouseEvent;
	//import flash.events.Event;

public class ConfigureDialog extends Dialog {
		private var languageBtn:SwitchButton;
		private var speakAudioBtn:SwitchButton;
		private var subtitleBtn:SwitchButton;
		private var closeBtn:CloseBtn;
		private function regEvents(){
			   languageBtn.addEventListener(SwitchButtonEvent.ON_CHANGE,onLangStatusChange);
			   speakAudioBtn.addEventListener(SwitchButtonEvent.ON_CHANGE,onSpeakStatusChange);
			   subtitleBtn.addEventListener(SwitchButtonEvent.ON_CHANGE,onSubtitleStatusChange);
			   closeBtn.addEventListener(MouseEvent.CLICK,onExecute);
			}
		private function onLangStatusChange(evt:SwitchButtonEvent){
			 trace("language|"+ evt.getParam());
			 Constant.setLanguage(evt.getParam()); 
			 evt.stopImmediatePropagation();
			}	
		private function onSpeakStatusChange(evt:SwitchButtonEvent){
			 Constant.setSpeakAudio(evt.getParam());
			 evt.stopImmediatePropagation();
			 trace("speak|"+evt.getParam());
			}	
		private function onSubtitleStatusChange(evt:SwitchButtonEvent){
			 Constant.subtitleSwitch = evt.getParam();
			 evt.stopImmediatePropagation();
			 var e:SwitchButtonEvent = new SwitchButtonEvent(SwitchButtonEvent.ON_CHANGE);
			 e.setParam(Constant.subtitleSwitch);
			 trace("subtitle switch|"+evt.getParam());
			 evt.stopImmediatePropagation();
			 dispatchEvent(e);
			}	
		public function ConfigureDialog() {
			this.x = 340;
			this.y = 210;
			languageBtn = new SwitchButton(257.5,56,Constant.getLanguage());
			speakAudioBtn = new SwitchButton(257.5,102,Constant.getSpeakAudio());
			subtitleBtn = new SwitchButton(257.5,148,Constant.subtitleSwitch);
			closeBtn = new CloseBtn();
			closeBtn.x = 420;
			closeBtn.y  = 10;
			addChild(languageBtn);
			addChild(speakAudioBtn);
			addChild(subtitleBtn);
			addChild(closeBtn);
			regEvents();
			this.setDragable(true);
			//this.visible = false;
		}//end function construction
	}//end class
}//end package
