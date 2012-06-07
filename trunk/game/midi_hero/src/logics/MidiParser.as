package logics
{
	import com.adobe.serialization.json.JSON;
	import logics.SceneMgr; 
	import flash.events.*;
	import flash.net.*;
	import flash.net.URLLoader;
	
	import org.flixel.FlxTimer;

	public class MidiParser
	{
		private var m_json : Array;
		private var m_urlLoader : URLLoader;
		public function MidiParser()
		{
			m_urlLoader = new URLLoader();
			m_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			m_urlLoader.addEventListener(Event.COMPLETE, parseJson);
			m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
		}
		
		static private var m_instance : MidiParser = null;
		
		static public function getInstance() : MidiParser
		{
			if (m_instance == null)
				m_instance = new MidiParser();
			return m_instance;
		}
		
		public function loadJson(jsonUrl : String) : void
		{
			m_urlLoader.load(new URLRequest(jsonUrl));
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
				
			}
			
			
			
			
		}
		
		private function handleError(event : IOErrorEvent) : void
		{
			trace(event.text);
		}
	}
}