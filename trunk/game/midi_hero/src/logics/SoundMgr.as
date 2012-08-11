package logics
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.*;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.*;
	import flash.net.URLLoader;
	import flash.media.SoundMixer;


	public class SoundMgr
	{
		public function SoundMgr()
		{
			m_sound = new Sound();
			m_sound.addEventListener( SampleDataEvent.SAMPLE_DATA, onSampleData );
			m_restLength = 10;
			m_amplitude = 1.0;
			m_soundTransform = new SoundTransform();
			
		}
		
		private var m_noteNew : Boolean;
		private static var m_instance : SoundMgr = null;
		private var m_curNote : String;
		private var m_sound : Sound;
		private var m_curChannel : SoundChannel;
		private var m_lastChannel : SoundChannel;
		private var m_amplitude : Number;
		private var m_restLength : int;
		public static const SAMPLE_RATE :int = 44100;
		public static const BUFFER_SIZE :int = 8192;
		private var m_noteFreq : Array;
		private var m_urlLoader : URLLoader;
		private var m_soundTransform : SoundTransform;
		
		/*
			load note_freq json file, and input the data into a map
		*/
		public function loadNoteFreq() : void
		{
			m_urlLoader = new URLLoader();
			m_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			m_urlLoader.addEventListener(Event.COMPLETE, parseJson);
			m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			m_urlLoader.load(new URLRequest("F:\\MidiHero\\midi-hero\\trunk\\game\\midi_hero\\src\\note_freq.json"));
		}
		
		private function handleError(event : IOErrorEvent) : void
		{
			trace(event.text);
		}
		
		private function parseJson(event : Event) : void
		{
			var rawData:String = String(m_urlLoader.data);
			m_noteFreq = (com.adobe.serialization.json.JSON.decode(rawData) as Array);
				
		}
		
		public function get curNote():String
		{
			return m_curNote;
		}

		public function set curNote(value:String):void
		{
			m_curNote = value;
		}

		public static function getInstance() : SoundMgr
		{
			if (m_instance == null)
				m_instance = new SoundMgr();
			return m_instance;
		}
		
		public function stopSound() : void
		{
			SoundMixer.stopAll();
			/*
			if (m_curChannel != null)
			{
				m_lastChannel = m_curChannel;
				m_lastChannel.soundTransform.volume = 0;
			}*/
			//m_curChannel.soundTransform.volume = 0;
		}
		
		// call by ouside
		// to play a note with a given frequency and a given length
		public function changeNote(name : String, len : Number) : void
		{
			if (m_curChannel != null)
			{
				m_lastChannel = m_curChannel;
				//m_lastChannel.soundTransform.volume = 0;
			}
			m_curNote = name;
			m_noteNew = true;
			m_soundTransform.volume = 1.0;
			m_restLength = Math.floor(len * SAMPLE_RATE);
			
			m_curChannel = m_sound.play();
			m_curChannel.soundTransform.volume = 1.0;
			
			
		}
		
		// given name of note, return its frequency
		private function getFreq(name : String) : Number
		{
			for (var i: int = 0; i < m_noteFreq.length; ++i)
			{
				
				if (m_noteFreq[i].name == name)
					return m_noteFreq[i].freq;
			}
			return 0;
		}
		
		private function squareWave(sig : Number) : Number
		{
			if (sig > 0) return 2;
			else return -2;
		}
		
		private function onSampleData(event : SampleDataEvent) : void
		{
			var sample:Number;
			var freq : Number = getFreq(m_curNote);
			if (m_restLength == 0 && m_curChannel != null)
			{
				//m_curChannel.soundTransform.volume = 0;
			 	m_curChannel.stop();
				return;
			}
			
			for( var i:int = 0; i < 8192; i++ )
			{
				var scale : Number;
				if (m_restLength <= 0)
				{
					//trace(i);
					return;
				}
				m_restLength -= 1;
				
				sample = squareWave(Math.sin( Math.PI * 2 * freq * ( event.position + i ) / SAMPLE_RATE )) * m_amplitude;
				event.data.writeFloat( sample );
				event.data.writeFloat( sample );
			}
			//trace(8192);
			m_noteNew = false;
		}
	}
}