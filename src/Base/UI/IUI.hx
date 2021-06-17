class IUI extends h2d.Object
{
    public static var all(default, null) : List<IUI> = new List<IUI>();

    public function new()
    {
        super(Main.uiLayer);
        all.add(this);
    }
}