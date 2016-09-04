package swifter.core.texts {
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	import swifter.core.texts.TextSpeeds;
	import swifter.core.events.ChatEvent;
	import flash.display.Stage;
	
	/** 
	* Distribuido cuando la visualización del texto se ha completado totalmente.
	* 
	* <p>Este evento tiene las propiedades siguientes:</p> 
	* <table class="innertable"> 
	* <tr><th>Propiedad</th><th>Valor</th></tr> 
	* <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
	* <tr><td><code>cancelable</code></td><td><code>true</code></td></tr>
	* </table> 
	* 
	* @eventType swifter.core.events.ChatEvent
	*/ 
	[Event(name="chatFinished", type="swifter.core.events.ChatEvent")]
	
	/**
	* Un objeto ChatOrganizator es un cuadro de texto que sirve para mostrar diálogo.
	*/
	public class ChatOrganizator extends MovieClip {
		
		/** Crea un objeto <code>ChatOrganizator</code>.
		*/
		public function ChatOrganizator():void {
			
		}
		private var j:uint = 0;
		/** Muestra en el cuadro del objeto <code>ChatOrganizator</code> un texto. 
		* También se puede especificar el clip de sonido a reproducirse y
		* la velocidad con la que se reproduce.
		*
		* @param field El objeto <code>TextField</code> en el que se mostrará el texto.
		* Normalmente hace referencia al campo de texto del clip de película asociado.
		* @param text La cadena de texto CODN que se va a mostrar.
		* @param sfx El efecto de sonido que se reproducirá aproximadamente por cada
		* carácter mostrado en pantalla.
		* @param speed La velocidad con la que se mostrará el texto. 
		* La clase <code>TextSpeeds</code> contiene una lista de valores disponibles para
		* la velocidad del texto.
		* @default 50
		*/
		public function speak(field:TextField,text:String,sfx:Sound,speed:int=50):void {
			var i:uint = 0;
			var textInterval:uint = setInterval(parseString, speed);
			var voiceInterval:uint = setInterval(makeSound, speed*2);
			var output:String = "";
			function parseString():void {
				if(i <= text.length) {
					if(text.charAt(i) == "¬") {
						output+="<font color='#"+text.substr(i+1,6)+"'>";
						i+=7;
					} else {
						output += text.charAt(i);
						i++;
					}
					field.htmlText = output;
				} else {
					clearInterval(textInterval);
					dispatchEvent(new ChatEvent(ChatEvent.FINISH));
				}
			}
			function makeSound():void {
				if (i <= text.length) {
					sfx.play();
				} else {
					clearInterval(voiceInterval);
				}
			}
		}
		public function speakArray(field:TextField,dialogue:Array,pauseEvent:String,sfx:Sound,speed:int=50):void {
			this.addEventListener(ChatEvent.FINISH,enableNext);
			this.speak(field,dialogue[j],sfx,speed);
			function enableNext(e:ChatEvent):void {
				//_stage.addEventListener(Event.ADDED_TO_STAGE,onStage);
			}
			function onStage(e:Event):void {
				//stage.addEventListener(pauseEvent,onPause);
				trace("Added to Stage");
			}
			function onPause(e:Event):void {
				stage.removeEventListener(e.type,onPause);
				for(j=0;j<dialogue.length;j++) {
					this.speak(field,dialogue[j],sfx,speed);
				}
			}
		}
	}
	
}
