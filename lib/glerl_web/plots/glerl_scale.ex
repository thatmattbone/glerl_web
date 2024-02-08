defmodule Glerl.Web.GlerlTimeScale do
    defstruct []
end
  
defimpl Contex.Scale, for: Glerl.Web.GlerlTimeScale do
    # @spec ticks_domain(t()) :: list(any())
    def ticks_domain(scale) do
        IO.inspect(scale)
    end
  
    # @spec ticks_range(t()) :: list(number())
    def ticks_range(scale) do
        IO.inspect(scale)
    end
  
    # @spec domain_to_range_fn(t()) :: fun()
    def domain_to_range_fn(scale) do 
        IO.inspect(scale)
    end
  
    # @spec domain_to_range(t(), any()) :: number()
    def domain_to_range(scale, domain_val) do 
        IO.inspect(scale)
        IO.inspect(domain_val)
    end
  
    # @spec get_range(t()) :: {number(), number()}
    def get_range(scale) do 
        IO.inspect(scale)
    end
  
    # @spec set_range(t(), number(), number()) :: t()
    def set_range(scale, start, finish) do 
        IO.inspect(scale)
        IO.inspect(start)
        IO.inspect(finish)
    end
  
    # @spec get_formatted_tick(t(), number()) :: String.t()
    def get_formatted_tick(scale, tick_val) do 
        IO.inspect(scale)
        IO.inspect(tick_val)
    end
end