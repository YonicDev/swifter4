package swifter.core.texts {
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	import swifter.core.texts.TextSpeeds;
	import swifter.core.events.ChatEvent;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
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
		private var i:uint = 0;
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
		public function speak(field:TextField,text:String,sfx:Sound=null,speed:int=50,showHTML:Boolean=false):void {
			var i:uint = 0;
			var textInterval:uint = setInterval(parseString, speed);
			if(sfx!=null) {
			var voiceInterval:uint = setInterval(makeSound, speed*2);
			}
			field.text = "";
			var output:String = "";
			function parseString():void {
				if(i <= text.length) {
					if(text.charAt(i) == "\\") {
						i++;
						output+=text.charAt(i);
						i++;
					} else {
						if(text.charAt(i) == "¬") {
							if(text.charAt(i+1) == "¬") {
								output+="</font>";
								i+=2;
							} else {
								output+="<font color='#"+text.substr(i+1,6)+"'>";
								i+=7;
							}
						} else if(text.charAt(i) == "*") {
							if(text.charAt(i+1) == "*") {
								output+="</font>";
								i+=2;
							} else {
								output+="<font size='+"+text.substr(i+1,3)+"'>";
								i+=3;
							}
						} else if(text.charAt(i) == "_") {
								if(text.charAt(i+1) == "_") {
								output+="</u>";
								i+=2;
							} else {
								output+="<u>";
								i++;
							}
						} else {
							output += text.charAt(i);
							i++;
						}
					}
					if(showHTML) {
						field.text = output;
					} else {
						field.htmlText = output;
					}
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
		public function speakArray(field:TextField,dialogue:Array,pauseEvent:String,voice:Sound,skipSFX:Sound,speed:int=50,showHTML:Boolean=false):void {
			j=0;
			i=0;
			addEventListener(ChatEvent.FINISH,onFinished);
			speak(field,dialogue[0],voice,speed,showHTML);
			dispatchEvent(new ChatEvent(ChatEvent.BEGIN));
			function onFinished(e:Event):void {
				dispatchEvent(new ChatEvent(ChatEvent.WAIT));
				removeEventListener(ChatEvent.FINISH,onFinished);
				stage.addEventListener(pauseEvent,onPause);
			}
			function onPause(e:Event):void {
				//removeEventListener(ChatEvent.FINISH,onFinished);
				stage.removeEventListener(e.type,onPause);
				if(e is KeyboardEvent) {
					checkKeyboard(e as KeyboardEvent);
				} else {
					step();
				}
			}
			function checkKeyboard(e:KeyboardEvent) {
				if(e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER) {
					step();
				}
			}
			function step():void {
				i++;
				if(j<dialogue.length-1) {
					j++;
					if(skipSFX!=null)
						skipSFX.play();
					addEventListener(ChatEvent.FINISH,onFinished);
					speak(field,dialogue[j],voice,speed,showHTML);
					dispatchEvent(new ChatEvent(ChatEvent.SWITCH));
				} else {
					dispatchEvent(new ChatEvent(ChatEvent.FINISH_ARRAY));
				}
			}
		}
	}
	
}
