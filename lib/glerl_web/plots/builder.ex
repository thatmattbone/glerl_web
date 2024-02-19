defmodule Glerl.Web.Plots.Builder do
    alias Contex.{Dataset, Plot, LinePlot, ContinuousLinearScale, TimeScale, Scale}

    # TODO this is all kind of a tightly coupled mess right now.
    #  just playing with how to factor this out and how to build the best looking plot..

    @spec convert_to_contex_data(list(Glerl.Core.Datapoint.t())) :: Dataset.t()
    def convert_to_contex_data(data) do
        contex_dataset = for datapoint <- data do
            chicago_time = DateTime.shift_zone!(datapoint.timestamp, "America/Chicago")

            {
                chicago_time,
                datapoint.speed,
                datapoint.gusts,
                15,  # 15 knots, sail chicago suggested limit for inexperienced crew 
                20,  # 20 knots, sail chicago sailing limit 
            }
        end

        contex_dataset 
          |> Dataset.new(["X", "Wind Speed", "Gusting To", "15", "20"])
    end

    @spec build_point_plot(list(Glerl.Core.Datapoint.t())) :: Plot
    def build_point_plot(data) do
        dataset = convert_to_contex_data(data)

        first_timestamp_chi = List.first(data).timestamp |> DateTime.shift_zone!("America/Chicago")
        last_timestamp_chi = List.last(data).timestamp |> DateTime.shift_zone!("America/Chicago")
        

        y_scale = ContinuousLinearScale.new()
          |> ContinuousLinearScale.domain(0.0, 30.0)  # normally stop at 30 knots
          |> Scale.set_range(0.0, 30.0)  # normally stop at 30 knots
        y_scale = %{y_scale | interval_count: 8, interval_size: 5, display_decimals: 0}

        x_scale = TimeScale.new()
          |> TimeScale.domain(first_timestamp_chi, last_timestamp_chi)
        x_scale = %{x_scale | display_format: "%H:%M"}

        options = [
            mapping: %{x_col: "X", y_cols: ["Wind Speed", "Gusting To", "15", "20"]},
            custom_y_scale:  y_scale,
            custom_x_scale: x_scale,
            legend_setting: :legend_none
        ]

        Plot.new(dataset, LinePlot, 900, 500, options)
    end

    @spec build_point_plot__custom_scale(list(Glerl.Core.Datapoint.t())) :: Plot
    def build_point_plot__custom_scale(data) do
        data = Enum.reverse(data)
        IO.puts("build_point_plot__custom_scale()")
        dataset = convert_to_contex_data(data)

        first_timestamp_utc = List.first(data).timestamp |> IO.inspect()
        last_timestamp_utc = List.last(data).timestamp |> IO.inspect()

        IO.puts("*****************************************************")

        y_scale = ContinuousLinearScale.new()
          |> ContinuousLinearScale.domain(0.0, 30.0) # normally stop at 30 knots
          |> Scale.set_range(0.0, 30.0) # normally stop at 30 knots
        y_scale = %{y_scale | interval_count: 6, interval_size: 5, display_decimals: 0}

        x_scale = Glerl.Web.Plots.TimeScale.new({first_timestamp_utc, last_timestamp_utc})

        options = [
            mapping: %{x_col: "X", y_cols: ["Wind Speed", "Gusting To", "15", "20"]},
            custom_y_scale:  y_scale,
            custom_x_scale: x_scale,
            legend_setting: :legend_none,
            axis_label_rotation: 45,
        ]

        Plot.new(dataset, LinePlot, 900, 500, options)
    end    
end