abstract Array2D<T>(Array<Array<T>>) from Array<Array<T>> to Array<Array<T>> // TBA - next time
{
    public inline function new(sizeX : Int, sizeY : Int, ?defaultValue : T)
    {
        this = new Array<Array<T>>();
        for (x in 0...sizeX)
        {
            this.push(new Array<T>());
            for (y in 0...sizeY)
            {
                this[x].push(defaultValue);
            }
        }
    }

    public static inline function fromFunction<T>(sizeX : Int, sizeY : Int, func : (x : Int, y : Int) -> T) : Array2D<T>
    {
        var arr = new Array<Array<T>>();
        for (x in 0...sizeX)
        {
            arr.push(new Array<T>());
            for (y in 0...sizeY)
            {
                arr[x].push(func(x, y));
            }
        }
        return arr;
    }
}