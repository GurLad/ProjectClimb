abstract Array2D<T>(Array<Array<T>>) from Array<Array<T>> to Array<Array<T>> // TBA - next time
{
    public inline function new(sizeX : Int, sizeY : Int, ?defaultValue : T)
    {
        this = new Array<Array<T>>();
        for (x in 0...(sizeX - 1))
        {
            this.push(new Array<T>());
            for (y in 0...(sizeY - 1))
            {
                this[x].push(defaultValue);
            }
        }
    }

    public static inline function fromFunction<T>(sizeX : Int, sizeY : Int, func : (x : Int, y : Int) -> T) : Array2D<T>
    {
        var arr = new Array<Array<T>>();
        for (x in 0...(sizeX - 1))
        {
            arr.push(new Array<T>());
            for (y in 0...(sizeY - 1))
            {
                arr[x].push(func(x, y));
            }
        }
        return arr;
    }
}