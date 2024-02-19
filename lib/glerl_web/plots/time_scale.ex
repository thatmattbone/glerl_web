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
    def ticks_domain(scale=%Glerl.Web.Plots.TimeScale{domain: {min_d, max_d}}) do
        IO.puts("ticks_domain()")
        IO.inspect(scale)
        IO.puts("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

        min_d_secs = DateTime.to_unix(min_d, :second)
        max_d_secs = DateTime.to_unix(max_d, :second)

        # [1, 2, 3, 4, 5]
        for time_secs <- (min_d_secs+100)..max_d_secs//600 do
            DateTime.from_unix!(time_secs, :second) |> DateTime.shift_zone!("America/Chicago")
        end |> IO.inspect()
    end
  
    # @spec ticks_range(t()) :: list(number())
    def ticks_range(scale=%Glerl.Web.Plots.TimeScale{domain: {min_d, max_d}}) do
        IO.puts("ticks_range()")
        IO.inspect(scale)
        IO.puts("/////////////////////////////////////////////////////")

        # [1, 2, 3, 4, 5]

        min_d_secs = DateTime.to_unix(min_d, :second)
        max_d_secs = DateTime.to_unix(max_d, :second)

        for time_secs <- min_d_secs..max_d_secs//300 do
            DateTime.from_unix!(time_secs, :second) |> DateTime.shift_zone!("America/Chicago")
        end
    end
  
    # @spec domain_to_range_fn(t()) :: fun()
    def domain_to_range_fn(%Glerl.Web.Plots.TimeScale{domain: {min_d, _max_d}}=scale) do 
        IO.puts("domain_to_range_fn()")
        IO.inspect(scale)        

        my_func = fn(x) ->
            # IO.puts("my domain_to_range_fn()")
            # IO.inspect(x)
            # IO.inspect(min_d)
            # IO.puts("*****************************************************")

            # domain_width = Utils.date_diff(max_d, min_d, :microsecond)            
            #
            # milliseconds_val = Utils.date_diff(domain_val, min_d, :microsecond)
            # ratio = (milliseconds_val - domain_min) / domain_width
            # min_r + ratio * range_width

            DateTime.diff(x, min_d, :second)
        end

        IO.inspect(my_func)

        IO.puts("*****************************************************")

        my_func
    end
  
    # @spec domain_to_range(t(), any()) :: number()
    def domain_to_range(scale, domain_val) do 
        IO.puts("domain_to_range()")
        IO.inspect(scale)
        IO.inspect(domain_val)
        IO.puts("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

        domain_val
    end
  
    # @spec get_range(t()) :: {number(), number()}
    def get_range(%Glerl.Web.Plots.TimeScale{domain: {min_d, max_d}}=scale) do
        IO.puts("get_range()")
        IO.inspect(scale)
        ret_val = {0, DateTime.diff(max_d, min_d, :second)} |> IO.inspect()
        IO.puts("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")

        ret_val
    end
  
    # @spec set_range(t(), number(), number()) :: t()
    def set_range(scale, start, finish) do
        # need to find out what calls this because I think the Plot itself (or some other outside thing) is determining 
        # the width of the range and asking us to honor it.
        # I figured we'd be setting that width in here, but if that were the case this function probably wouldn't be needed.

        # First
        #     {Contex.Scale.Glerl.Web.Plots.TimeScale, :set_range, 3,
        #     [file: ~c"lib/glerl_web/plots/time_scale.ex", line: 110]},
        #    {Contex.LinePlot, :prepare_x_scale, 1,
        #     [file: ~c"lib/chart/lineplot.ex", line: 304]},
        #    {Contex.LinePlot, :prepare_scales, 1,
        #     [file: ~c"lib/chart/lineplot.ex", line: 291]},
        #    {Contex.LinePlot, :get_legend_scales, 1,
        #     [file: ~c"lib/chart/lineplot.ex", line: 181]},
        #    {Contex.Plot, :calculate_margins, 1,
        #     [file: ~c"lib/chart/plot.ex", line: 377]},        
        # 
        # Second
        # {Contex.Scale.Glerl.Web.Plots.TimeScale, :set_range, 3,
        #  [file: ~c"lib/glerl_web/plots/time_scale.ex", line: 123]},
        # {Contex.LinePlot, :prepare_x_scale, 1,
        #  [file: ~c"lib/chart/lineplot.ex", line: 304]},
        # {Contex.LinePlot, :prepare_scales, 1,
        #  [file: ~c"lib/chart/lineplot.ex", line: 291]},
        # {Contex.LinePlot, :get_legend_scales, 1,
        #  [file: ~c"lib/chart/lineplot.ex", line: 181]},
        # {Contex.Plot, :to_svg, 1, [file: ~c"lib/chart/plot.ex", line: 210]},
        #
        # Third
        # {Contex.Scale.Glerl.Web.Plots.TimeScale, :set_range, 3,
        #  [file: ~c"lib/glerl_web/plots/time_scale.ex", line: 123]},
        # {Contex.LinePlot, :prepare_x_scale, 1,
        #  [file: ~c"lib/chart/lineplot.ex", line: 304]},
        # {Contex.LinePlot, :prepare_scales, 1,
        #  [file: ~c"lib/chart/lineplot.ex", line: 291]},
        # {Contex.LinePlot, :to_svg, 2, [file: ~c"lib/chart/lineplot.ex", line: 189]},
        # {Contex.Plot, :to_svg, 1, [file: ~c"lib/chart/plot.ex", line: 236]},
 

        IO.puts("set_range()")
        IO.inspect(scale)
        IO.inspect(start)
        IO.inspect(finish)
        IO.puts("*****************************************************")

        dbg()

        scale
    end
  
    # @spec get_formatted_tick(t(), number()) :: String.t()
    def get_formatted_tick(scale, %{hour: hour, minute: minute} = tick_val) do 
        # IO.puts("get_formatted_tick()")
        # IO.inspect(scale)
        # IO.inspect(tick_val)
        # IO.puts("*****************************************************")

        # DateTime.to_string(tick_val)
        "#{hour}:#{minute}"
    end
end