package swifter.core.events  {
	import flash.events.Event;
	
	/**
	* La clase ChatOrganizator distribuye eventos ChatEvent a medida que cambia el flujo del diálogo en el cuadro.
	*/
	public class ChatEvent extends Event {
		/** Define el valor de la propiedad 
		* <code>type</code> de un objeto de evento  
		* <code>chatFinished</code>.
		* <p>Este evento tiene las propiedades siguientes:</p> 
		* <table class="innertable"> 
		* <tr><th>Propiedad</th><th>Valor</th></tr> 
		* <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		* <tr><td><code>cancelable</code></td><td><code>true</code></td></tr>
		* </table> 
		* 
		* @eventType buttonDown 
		*/
		public static const FINISH:String = "onChatFinished";
		public static const WAIT:String = "onChatWait";
		public static const APPEAR:String = "chatBoxAppeared";
		public static const DISAPPEAR:String = "chatBoxHidden";
		public static const SWITCH:String = "onChatSwitch";
		public static const BEGIN:String = "onChatBegin";
		public static const FINISH_ARRAY:String = "onChatArrayFinished";
		
		/**Crea un objeto de evento que contiene información sobre eventos de un objeto ChatOrganizator.
		*/
		public function ChatEvent(type:String, bubbles:Boolean=false,cancelable:Boolean=false):void {
			super(type,bubbles,cancelable);
		}

	}
	
}
