�������ر�
import com.skynetsoft.events.ProgressBarEnableEvent;
dispatchEvent(new ProgressBarEnableEvent(ProgressBarEnableEvent.DISABLE));

��������
import com.skynetsoft.events.ProgressBarEnableEvent;
dispatchEvent(new ProgressBarEnableEvent(ProgressBarEnableEvent.ENABLE));

ע��������Ĵ򿪺͹رղ�����������ڵ�һ֡�ϡ�

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

������ת����

import flash.events.Event;
import com.skynetsoft.events.LoaderEvent;
import com.skynetsoft.events.FrameLabelEvent;

/* ��ʾ����
��ʾָ����Ԫ��ʵ����

˵��:
1. ʹ�ô˴�����ʾ��ǰ���صĶ���
*/

button_1.visible = true;


button_1.addEventListener(MouseEvent.CLICK, on_MouseClickHandler_skip);

function on_MouseClickHandler_skip(event:MouseEvent):void
{

	var pEvt:FrameLabelEvent = new FrameLabelEvent(FrameLabelEvent.FRAME_LABEL_SKIP);
	pEvt.frameLabel = "A003";
	dispatchEvent(pEvt);
	// ��ʼ�����Զ������
	// ��ʾ��������"���"�������ʾ"�ѵ������"��
	trace("��ǩ��Ծ�¼�");
	// ���������Զ������
}


button4Play.addEventListener(MouseEvent.CLICK, on_MouseClickHandler_Play);

function on_MouseClickHandler_Play(event:MouseEvent):void
{
	
	var pEvt:LoaderEvent = new LoaderEvent(LoaderEvent.REPLAY);
	dispatchEvent(pEvt);
	// ��ʼ�����Զ������
	// ��ʾ��������"���"�������ʾ"�ѵ������"��
	trace("�׳��������ŵ��¼�");
}


button4Pause.addEventListener(MouseEvent.CLICK, on_MouseClickHandler_Pause);

function on_MouseClickHandler_Pause(event:MouseEvent):void
{
	var pEvt:LoaderEvent = new LoaderEvent(LoaderEvent.PAUSE);
	dispatchEvent(pEvt);
	trace("�׳���ͣ���ŵ��¼�");
}


