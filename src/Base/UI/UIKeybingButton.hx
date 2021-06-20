class UIKeybindButton extends UIButton
{
    private var binding : Bool = false;
    private var playerID : Int;
    private var inputType : InputType;

    public function new(pos : Vector, sizeMod : Int, image : hxd.res.Image, playerID : Int, inputType : InputType)
    {
        super(pos, sizeMod, "", () -> { binding = true; text.textColor = 0xFFFF00; });
        this.inputType = inputType;
        this.playerID = playerID;
        switch (inputType)
        {
            case Jump:
                text.text = hxd.Key.getKeyName(Input.jumpButton[playerID]);
            case Cast:
                text.text = hxd.Key.getKeyName(Input.castButton[playerID]);
        }
        hxd.Window.getInstance().addEventTarget(bindKey);
    }

    private function bindKey(event : hxd.Event)
    {
        if (event.kind == EKeyDown)
        {
            if (binding)
            {
                switch (inputType)
                {
                    case Jump:
                        Input.jumpButton[playerID] = event.keyCode;
                    case Cast:
                        Input.castButton[playerID] = event.keyCode;
                }
                text.text = hxd.Key.getKeyName(event.keyCode);
                binding = false;
                text.textColor = 0xFFFFFF;
            }
        }
    }
}