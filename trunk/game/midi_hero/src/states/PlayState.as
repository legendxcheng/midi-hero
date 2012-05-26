// ActionScript file
package states
{
	import org.flixel.*;
	
	import sprites.Note;
	
	public class PlayState extends FlxState
	{
		override public function create():void
		{
			//add(new FlxText(0,0,100,"Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			var note : Note = new Note(100);
			note.changeNote(0xFFAA0FF0, 400);
			add(note);
			note.x = 300;
			note.y = 000;
		}
	}
}