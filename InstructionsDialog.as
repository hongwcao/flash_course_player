package  {
    import com.skynetsoft.util.Dialog;
	import flash.events.MouseEvent;

	public class InstructionsDialog extends Dialog {
		private var closeBtn:CloseBtn;
		
		public function InstructionsDialog() {
			this.x = 500;
			this.y = 70;
			this.setDragable(true);
			closeBtn = new CloseBtn();
			closeBtn.x = 470;
			closeBtn.y = 11;
			addChild(closeBtn);
			closeBtn.addEventListener(MouseEvent.CLICK,onExecute);
		}
	}
}
