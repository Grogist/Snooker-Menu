class SnookerMenu extends HUD;

var SnookerMenuGFxMovie HUDMovie;

var class<SnookerMenuGFxMovie>	HUDMovieClass;

var GFxObject	HUDMovieSize;

var SnookerMouseInterfacePlayerInput MouseInterfacePlayerInput;
var float MouseX, MouseY;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	CreateHUDMovie();

	HUDMovieSize = HUDMovie.GetVariableObject("Stage.originalRect");
	
	MouseInterfacePlayerInput = SnookerMouseInterfacePlayerInput(PlayerOwner.PlayerInput);
}

function CreateHUDMovie()
{
	HUDMovie = new HUDMovieClass;
	
	HUDMovie.SetTimingMode(TM_Real);
	HUDMovie.Init(class'Engine'.static.GetEngine().GamePlayers[HUDMovie.LocalPlayerOwnerIndex]);
	
	HUDMovie.SetViewScaleMode(SM_NoScale);
	HUDMovie.SetAlignment(Align_TopLeft);
}

defaultproperties
{
	HUDMovieClass = class'SnookerMenuGFxMovie'
}