package logics
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.*;
	import flash.net.*;
	import flash.net.URLLoader;
	
	import logics.SceneMgr;
	
	import org.flixel.FlxTimer;

	public class MidiParser
	{
		private var m_json : Array;
		private var m_urlLoader : URLLoader;
			
		public function MidiParser()
		{
			
		}
		
		static private var m_instance : MidiParser = null;
		
		static public function getInstance() : MidiParser
		{
			if (m_instance == null)
				m_instance = new MidiParser();
			return m_instance;
		}
		
		public function loadMusicList() : void
		{
			m_urlLoader = new URLLoader();
			m_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			m_urlLoader.addEventListener(Event.COMPLETE, parseMusicList);
			m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			m_urlLoader.load(new URLRequest("http://xcheng.sinaapp.com/media/midihero/musicList.json"));
		}
		
		public function loadJson(jsonUrl : String) : void
		{
			m_urlLoader = new URLLoader();
			m_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			m_urlLoader.addEventListener(Event.COMPLETE, parseMusicList);
			m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			m_urlLoader.load(new URLRequest(jsonUrl));
		}
		
		private function calcHigh(ss : String) : int
		{
			switch (ss)
			{
				case "C":
					return 0;
					break;
				case "C#":
					return 1;
					break;
				case "D":
					return 2;
					break;
				case "E-":
					return 3;
					break;
				case "E":
					return 4;
					break;
				case "F":
					return 5;
					break;
				case "F#":
					return 6;
					break;
				case "G":
					return 7;
					break;
				case "G#":
					return 8;
					break;
				case "A":
					return 9;
					break;
				case "B-":
					return 10;
					break;
				case "B":
					return 11;
					break;
			}
			return 0;
		}
		
		private function parseJson(event : Event) : void
		{
			var rawData:String = String(m_urlLoader.data);
			m_json = (com.adobe.serialization.json.JSON.decode(rawData) as Array);
			// now we have the score data
			// we parse it to a more convenient format
			// then pass it to SceneMgr
			var sm : SceneMgr = SceneMgr.getInstance();
			var ni : Array = new Array();
			for (var i : int = 0; i < m_json.length; ++i)
			{
				var tmp : int = (m_json[i].octave - 3) * 21;
				
				if (m_json[i].pitch.charCodeAt(0) >= 'A'.charCodeAt(0) && m_json[i].pitch.charCodeAt(0) <= 'B'.charCodeAt(0))
				{
					tmp += 6 + m_json[i].pitch.charCodeAt(0) - 'A'.charCodeAt(0);
				}
				else
				{
					tmp += m_json[i].pitch.charCodeAt(0) - 'C'.charCodeAt(0);
				}
				
				if (m_json[i].pitch.length > 1)
				{
					var d : String;
					
					if (m_json[i].pitch.charAt(1) == '#')
						tmp += 1;
					else tmp -= 1;
				}
				var noteName : String = m_json[i].octave.toString() + m_json[i].pitch;
				ni.push({start: m_json[i].start , end : m_json[i].end, notePos : tmp * 2, 
					high : (m_json[i].octave - 3) * 12 + calcHigh(m_json[i].pitch) + 20, name : noteName,
					hit : 0});
				/* hit  0 not need play
				 		1 played
						2 missed
				*/
			}
			
			sm.setNoteInfo(ni);
			m_urlLoader.removeEventListener(Event.COMPLETE, parseJson);
			
		}
		
		private function parseMusicList(event : Event) : void
		{
			var gl :GameLogic = GameLogic.getInstance();
			var rawData:String = String(m_urlLoader.data);
			m_json = (com.adobe.serialization.json.JSON.decode(rawData) as Array);
			// now we have the score data
			// we parse it to a more convenient format
			// then pass it to SceneMgr
			var ni : Array = new Array();
			for (var i : int = 0; i < m_json.length; ++i)
			{
				var tid : int = m_json[i].id;
				var tname : String = m_json[i].name;
				var taddr : String = m_json[i].addr;
				
				ni.push({id: m_json[i].id , name : m_json[i].name, addr : m_json[i].addr});
				/* hit  0 not need play
				1 played
				2 missed
				*/
			}
			
			gl.musicList = ni;
			
			m_urlLoader.removeEventListener(Event.COMPLETE, parseMusicList);
		}
		
		private function handleError(event : IOErrorEvent) : void
		{
			trace(event.text);
		}
	}
}