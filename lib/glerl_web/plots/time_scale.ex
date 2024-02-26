defmodule Glerl.Web.Plots.TimeScale do
    defstruct [
        :custom_tick_formatter,
        :domain,
        :range,
    ]

    @type t :: %__MODULE__{
        custom_tick_formatter: any,
        domain: {DateTime.t(), DateTime.t()},
        range: {number(), number()}
    }

    @spec new({DateTime.t(), DateTime.t()}) :: t()
    def new({min_d=%DateTime{}, max_d=%DateTime{}}) do
        %__MODULE__{
            domain: {min_d, max_d}
        }
    end
end
  
defimpl Contex.Scale, for: Glerl.Web.Plots.TimeScale do
    def ticks_domain(%Glerl.Web.Plots.TimeScale{domain: {min_d, max_d}}) do
        min_d_secs = DateTime.to_unix(min_d, :second)
        max_d_secs = DateTime.to_unix(max_d, :second)

        for time_secs <- (min_d_secs+100)..max_d_secs//600 do
            DateTime.from_unix!(time_secs, :second) |> DateTime.shift_zone!("America/Chicago")
        end
    end
  
    def ticks_range(%Glerl.Web.Plots.TimeScale{domain: {min_d, max_d}}) do
        min_d_secs = DateTime.to_unix(min_d, :second)
        max_d_secs = DateTime.to_unix(max_d, :second)

        for time_secs <- min_d_secs..max_d_secs//300 do
            DateTime.from_unix!(time_secs, :second) |> DateTime.shift_zone!("America/Chicago")
        end
    end
  
    def domain_to_range_fn(%Glerl.Web.Plots.TimeScale{domain: {min_d, max_d}, range: {min_r, max_r}}) do   
        range_width = max_r - min_r
        domain_width = DateTime.diff(max_d, min_d, :second)

        my_func = fn(x) ->
            seconds_diff = DateTime.diff(x, min_d, :second)
            ratio = seconds_diff / domain_width
            min_r + ratio * range_width
        end

        my_func
    end
  
    def domain_to_range(_scale, domain_val) do 
        domain_val
    end
  
    def get_range(%Glerl.Web.Plots.TimeScale{range: range}) do
        range
    end
  
    def set_range(scale, start, finish) do
        %{scale | range: {start, finish}}
    end
  
    def get_formatted_tick(_scale, %{hour: hour, minute: minute}) do
        minute_str = minute |> Integer.to_string() |> String.pad_leading(2, "0")

        "#{hour}:#{minute_str}"
    end
end