defmodule Glerl.Web.Plots.TimeScale do
    defstruct [
        :custom_tick_formatter
    ]

    def new() do 
        %__MODULE__{}
    end
end
  
defimpl Contex.Scale, for: Glerl.Web.Plots.TimeScale do
    # @spec ticks_domain(t()) :: list(any())
    def ticks_domain(scale) do
        IO.puts("ticks_domain()")
        IO.inspect(scale)
    end
  
    # @spec ticks_range(t()) :: list(number())
    def ticks_range(scale) do
        IO.puts("ticks_range()")
        IO.inspect(scale)
    end
  
    # @spec domain_to_range_fn(t()) :: fun()
    def domain_to_range_fn(scale) do 
        IO.puts("domain_to_range_fn()")
        IO.inspect(scale)

        fn(x) ->
            IO.puts("my domain_to_range_fn()")
            IO.inspect(x)

            x
        end
    end
  
    # @spec domain_to_range(t(), any()) :: number()
    def domain_to_range(scale, domain_val) do 
        IO.puts("domain_to_range_fn()")
        IO.inspect(scale)
        IO.inspect(domain_val)
    end
  
    # @spec get_range(t()) :: {number(), number()}
    def get_range(scale) do
        IO.puts("get_range()")
        IO.inspect(scale)
    end
  
    # @spec set_range(t(), number(), number()) :: t()
    def set_range(scale, start, finish) do 
        IO.puts("set_range()")
        IO.inspect(scale)
        IO.inspect(start)
        IO.inspect(finish)

        scale
    end
  
    # @spec get_formatted_tick(t(), number()) :: String.t()
    def get_formatted_tick(scale, tick_val) do 
        IO.puts("get_formatted_tick()")
        IO.inspect(scale)
        IO.inspect(tick_val)
    end
end