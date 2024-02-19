defmodule Glerl.Web.Plots.TimeScale do
    defstruct [
        :custom_tick_formatter,
        :domain,
    ]

    @type t :: %__MODULE__{
        custom_tick_formatter: any,
        domain: {DateTime.t(), DateTime.t()}
    }

    @spec new({DateTime.t(), DateTime.t()}) :: t()
    def new({min_d=%DateTime{}, max_d=%DateTime{}}) do
        %__MODULE__{
            domain: {min_d, max_d}
        }
    end
end
  
defimpl Contex.Scale, for: Glerl.Web.Plots.TimeScale do
    # @spec ticks_domain(t()) :: list(any())
    def ticks_domain(scale) do
        IO.puts("ticks_domain()")
        IO.inspect(scale)
        IO.puts("*****************************************************")

        [1, 2, 3, 4, 5]
    end
  
    # @spec ticks_range(t()) :: list(number())
    def ticks_range(scale) do
        IO.puts("ticks_range()")
        IO.inspect(scale)
        IO.puts("*****************************************************")

        [1, 2, 3, 4, 5]
    end
  
    # @spec domain_to_range_fn(t()) :: fun()
    def domain_to_range_fn(scale) do 
        IO.puts("domain_to_range_fn()")
        IO.inspect(scale)
        IO.puts("*****************************************************")

        my_func = fn(x) ->
            IO.puts("my domain_to_range_fn()")
            IO.inspect(x)
            IO.puts("*****************************************************")

            # DateTime.diff(a, b, :microsecond)

            # milliseconds_val = Utils.date_diff(domain_val, min_d, :microsecond)
            # ratio = (milliseconds_val - domain_min) / domain_width
            # min_r + ratio * range_width

            x
        end

        IO.inspect(my_func)

        my_func
    end
  
    # @spec domain_to_range(t(), any()) :: number()
    def domain_to_range(scale, domain_val) do 
        IO.puts("domain_to_range()")
        IO.inspect(scale)
        IO.inspect(domain_val)
        IO.puts("*****************************************************")

        domain_val
    end
  
    # @spec get_range(t()) :: {number(), number()}
    def get_range(scale) do
        IO.puts("get_range()")
        IO.inspect(scale)
        IO.puts("*****************************************************")

        {0, 100}
    end
  
    # @spec set_range(t(), number(), number()) :: t()
    def set_range(scale, start, finish) do 
        IO.puts("set_range()")
        IO.inspect(scale)
        IO.inspect(start)
        IO.inspect(finish)
        IO.puts("*****************************************************")

        scale
    end
  
    # @spec get_formatted_tick(t(), number()) :: String.t()
    def get_formatted_tick(scale, tick_val) do 
        IO.puts("get_formatted_tick()")
        IO.inspect(scale)
        IO.inspect(tick_val)
        IO.puts("*****************************************************")

        tick_val
    end
end