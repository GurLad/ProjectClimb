class GridPos
{
    public var cx : Int;
    public var cy : Int;
    public var tx : Int;
    public var ty : Int;

    public function new(rect : Rectangle)
    {
        cx = Math.floor(rect.topLeft.x / LDtkController.TRUE_TILE_SIZE);
        cy = Math.floor(rect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        tx = Math.floor(rect.bottomRight.x / LDtkController.TRUE_TILE_SIZE) - Math.floor(rect.topLeft.x / LDtkController.TRUE_TILE_SIZE);
        ty = Math.floor(rect.bottomRight.y / LDtkController.TRUE_TILE_SIZE) - Math.floor(rect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
    }

    public static function fromTwoRects(xRect : Rectangle, yRect : Rectangle) : GridPos
    {
        var gridPos : GridPos = new GridPos(xRect);
        gridPos.cy = Math.floor(yRect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        gridPos.ty = Math.floor(yRect.bottomRight.y / LDtkController.TRUE_TILE_SIZE) - Math.floor(yRect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        return gridPos;
    }
}