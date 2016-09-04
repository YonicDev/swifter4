package swifter.mercury{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class MP3Loop {
		import flash.events.Event;
		import flash.events.IOErrorEvent;
		import flash.utils.ByteArray;
		import flash.events.SampleDataEvent;
		import flash.net.URLRequest;
		import flash.media.Sound;
		
		public static var soundChannel:SoundChannel;
		
		public static function playLoop(sound:Sound, samplesTotal:int, loopPoint:int=0, channel:SoundChannel=null, soundTransform:SoundTransform = null):void {
			const MAGIC_DELAY:Number = 2257.0;// LAME 3.98.2 + flash.media.Sound Delay

			const bufferSize:int = 4096;// Stable playback
			
			const out:Sound = new Sound();
			var samplesPosition:int = 0;
			function startPlayback():void {
				out.addEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );
				
				if(channel!=null) {
					if(soundTransform!=null) {
						channel.soundTransform = soundTransform;
						channel = out.play(0,0,channel.soundTransform);
					} else {
						channel = out.play();
					}
				soundChannel = channel;
				} else {
					out.play();
				}
			}

			function sampleData( event:SampleDataEvent ):void {
				if(soundTransform!=null)
				trace(soundTransform.volume);
				extract( event.data, bufferSize );
			}

			function extract( target: ByteArray, length:int ):void {
				while ( 0 < length ) {
					if ( samplesPosition + length > samplesTotal ) {
						var read:int = samplesTotal - samplesPosition;

						sound.extract( target, read, samplesPosition + MAGIC_DELAY )

						samplesPosition +=  read;

						length -=  read;
					} else {
						sound.extract( target, length, samplesPosition + MAGIC_DELAY );

						samplesPosition +=  length;

						length = 0;
					}

					if ( samplesPosition == samplesTotal ) {
						samplesPosition = loopPoint;
					}
				}
			}
			startPlayback();
		}
		
		public static function playWebLoop(soundURL:URLRequest, samplesTotal:int, loopPoint:int=0) {
			const MAGIC_DELAY:Number = 2257.0;// LAME 3.98.2 + flash.media.Sound Delay

			const bufferSize:int = 4096;// Stable playback

			const mp3:Sound = new Sound();// Use for decoding
			const out:Sound = new Sound();// Use for output stream


			var samplesPosition:int = 0;

			function loadMp3():void {
				mp3.load(soundURL);
				mp3.addEventListener(Event.COMPLETE,startPlayback);
				mp3.addEventListener(IOErrorEvent.IO_ERROR,mp3Error);
			}
			function startPlayback(e:Event):void {
				out.addEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );
				out.play();
			}

			function sampleData( event:SampleDataEvent ):void {

				extract( event.data, bufferSize );
			}

			function extract( target: ByteArray, length:int ):void {
				while ( 0 < length ) {
					if ( samplesPosition + length > samplesTotal ) {
						var read:int = samplesTotal - samplesPosition;

						mp3.extract( target, read, samplesPosition + MAGIC_DELAY );

						samplesPosition +=  read;

						length -=  read;
					} else {
						mp3.extract( target, length, samplesPosition + MAGIC_DELAY );

						samplesPosition +=  length;

						length = 0;
					}

					if ( samplesPosition == samplesTotal ) {
						samplesPosition = loopPoint;
					}
				}
			}
			function mp3Error( event:IOErrorEvent ):void {
				trace( event );
			}
			loadMp3();
		}
		public static function playLocalLoop(soundClass:Class, samplesTotal:int, loopPoint:int=0) {
			const MAGIC_DELAY:Number = 2257.0;// LAME 3.98.2 + flash.media.Sound Delay

			const bufferSize:int = 4096;// Stable playback

			const mp3:Sound = new soundClass();// Use for decoding
			const out:Sound = new Sound();
			var samplesPosition:int = 0;
			function startPlayback():void {
				out.addEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );
				out.play();
			}

			function sampleData( event:SampleDataEvent ):void {

				extract( event.data, bufferSize );
			}

			function extract( target: ByteArray, length:int ):void {
				while ( 0 < length ) {
					if ( samplesPosition + length > samplesTotal ) {
						var read:int = samplesTotal - samplesPosition;

						mp3.extract( target, read, samplesPosition + MAGIC_DELAY );

						samplesPosition +=  read;

						length -=  read;
					} else {
						mp3.extract( target, length, samplesPosition + MAGIC_DELAY );

						samplesPosition +=  length;

						length = 0;
					}

					if ( samplesPosition == samplesTotal ) {
						samplesPosition = loopPoint;
					}
				}
			}
			startPlayback();
		}

	}

}