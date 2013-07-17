class SnookerMenuGFxMovie extends GFxMoviePlayer;

var array<ASValue> args;

var WorldInfo ThisWorld;
var SnookerPlayerController SPC;

var GFxClikWidget LevelList;

var GFxClikWidget NameTxtFld, HostBtn, JoinBtn, JoinTxtFld, ExitBtn;

var GFxObject RootMC, MouseContainer, MouseCursor;

function Init(optional LocalPlayer player)
{
	local SnookerMouseInterfacePlayerInput MouseInputPlayerInput;
	
	super.Init(player);
	ThisWorld = GetPC().WorldInfo;
	
	SPC = SnookerPlayerController(GetPC());
	
	MouseInputPlayerInput = SnookerMouseInterfacePlayerInput(GetPC().PlayerInput);
	
	Start();
	Advance(0);
	
	RootMC = GetVariableObject("_root");
	
	MouseContainer = CreateMouseCursor();
	MouseCursor = MouseContainer.GetObject("my_cursor");
	if(SPC!=None)
		MouseCursor.SetPosition(MouseInputPlayerInput.MousePosition.X,MouseInputPlayerInput.MousePosition.Y);
	MouseContainer.SetBool("topmostlevel", true);
	
	self.bCaptureInput = true;
	self.bIgnoreMouseInput = false;
	
	AddFocusIgnoreKey('Escape');
}

function GFxObject CreateMouseCursor()
{
	return RootMC.AttachMovie("MouseContainer", "MouseCursor");
}

function OnHostButton(GFxClikWidget.EventData ev)
{
	local string playername;
	local string map;
	
	if(LevelList.GetInt("selectedIndex") == 0)
		map = "SnookerTable_1.udk";
	else if(LevelList.GetInt("selectedIndex") == 1)
		map = "SnookerTable_2.udk";
	else
		map = "SnookerTable_3.udk";
	
	if(NameTxtFld != None)
		playername = NameTxtFld.GetString("text");
	
	if(playername == "")
		NameTxtFld.SetString("defaultText", "Choose A Name" );
	else
		ConsoleCommand("open"@map$"?Listen=true?Name="$playername$"?Game=Snooker.SnookerGame");
}

function OnJoinButton(GFxClikWidget.EventData ev)
{
	local string ip;
	local string playername;
	
	ip = JoinTxtFld.GetString("text");
	
	if(ip == "")
	{
		return;
		
		//ip = JoinTxtFld.GetString("defaultText");
	}
	
	if(NameTxtFld != None)
		playername = NameTxtFld.GetString("text");
	
	if(playername == "")
		NameTxtFld.SetString("defaultText", "Choose A Name" );
	else
		ConsoleCommand("open"@ip$"?Name="$playername);
}

function OnExitButton(GFxClikWidget.EventData ev)
{
	ConsoleCommand("Exit");
}

/*var GFxClikWidget NameTxtFld, HostBtn, JoinBtn, JoinTxtFld, ExitBtn;*/

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{    
    switch(WidgetName)
    {
		case ('nameTextField'):
            NameTxtFld = GFxClikWidget(Widget);
			`log("nameTextField found!");
            break;
        case ('hostButton'):
            HostBtn = GFxClikWidget(Widget);
            HostBtn.AddEventListener('CLIK_click', OnHostButton);
			`log("hostButton found!");
            break;
		case ('joinButton'):
            JoinBtn = GFxClikWidget(Widget);
            JoinBtn.AddEventListener('CLIK_click', OnJoinButton);
			`log("joinButton found!");
            break;
		case ('joinTextField'):
            JoinTxtFld = GFxClikWidget(Widget);
			`log("joinTextField found!");
            break;
		case ('exitButton'):
            ExitBtn = GFxClikWidget(Widget);
			ExitBtn.AddEventListener('CLIK_click', OnExitButton);
			`log("exitButton found!");
            break;
		case ('levelSelect'):
			LevelList = GFxClikWidget(Widget);
			`log("levelList found!");
			break;
		default:
            break;
    }

    return true;
}

defaultproperties
{
	WidgetBindings.Add((WidgetName="nameTextField",WidgetClass=class'GFxClikWidget'))
    WidgetBindings.Add((WidgetName="hostButton",WidgetClass=class'GFxClikWidget'))
	WidgetBindings.Add((WidgetName="joinButton",WidgetClass=class'GFxClikWidget'))
	WidgetBindings.Add((WidgetName="joinTextField",WidgetClass=class'GFxClikWidget'))
	WidgetBindings.Add((WidgetName="exitButton",WidgetClass=class'GFxClikWidget'))
	WidgetBindings.Add((WidgetName="levelSelect",WidgetClass=class'GFxClikWidget'))
	
	MovieInfo = SwfMovie'TurretContent.SnookerMenu'
}