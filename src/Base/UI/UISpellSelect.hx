class UISpellSelect extends UIButton
{
    private static var NUM_SPELLS(default, never) = 4;
    private var buttons : Array<String> = ["Fire", "Water", "Air", "Earth"];

    public function new(pos : Vector, sizeMod : Int, playerID : Int)
    {
        super(pos, sizeMod, buttons[PlayerBuilder.playerSpells[playerID]], () -> nextSpell(playerID));
    }

    private function nextSpell(playerID : Int)
    {
        PlayerBuilder.playerSpells[playerID] = (PlayerBuilder.playerSpells[playerID] + 1) % NUM_SPELLS;
        text.text = buttons[PlayerBuilder.playerSpells[playerID]];
    }
}