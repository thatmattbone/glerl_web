defmodule Glerl.Web.Plots.Builder do
    alias Contex.{Dataset, Plot, LinePlot, ContinuousLinearScale, Scale}


    @spec max_wind_speed(list(Glerl.Core.Datapoint.t())) :: number()
    def max_wind_speed(glerl_datapoints) do
        speeds = glerl_datapoints |> Enum.map(fn datapoint -> datapoint.speed end)
        gusts = glerl_datapoints |> Enum.map(fn datapoint -> datapoint.gusts end)  # gusts should always be greater than wind speed but we'll be vigilant.

        Enum.max(speeds ++ gusts)
    end


    @spec calc_wind_range_from_max(number()) :: number()
    def calc_wind_range_from_max(max_wind) when max_wind < 30.0, do: 30.0
    def calc_wind_range_from_max(max_wind) when max_wind < 35.0, do: 35.0
    def calc_wind_range_from_max(max_wind) when max_wind < 40.0, do: 40.0
    def calc_wind_range_from_max(max_wind) when max_wind < 45.0, do: 45.0
    def calc_wind_range_from_max(max_wind) when max_wind < 50.0, do: 50.0
    def calc_wind_range_from_max(max_wind) when max_wind < 55.0, do: 55.0
    def calc_wind_range_from_max(max_wind) when max_wind < 60.0, do: 60.0
    def calc_wind_range_from_max(max_wind) when max_wind < 65.0, do: 65.0
    def calc_wind_range_from_max(max_wind) when max_wind < 70.0, do: 70.0
    def calc_wind_range_from_max(max_wind) when max_wind < 75.0, do: 75.0
    def calc_wind_range_from_max(max_wind) when max_wind < 80.0, do: 80.0
    def calc_wind_range_from_max(max_wind), do: max_wind + 5.0


    @spec convert_to_contex_data(list(Glerl.Core.Datapoint.t())) :: Dataset.t()
    def convert_to_contex_data(gler_datapoints) do
        contex_dataset = for datapoint <- gler_datapoints do
            chicago_time = DateTime.shift_zone!(datapoint.timestamp, "America/Chicago")

            {
                chicago_time,
                datapoint.speed,
                datapoint.gusts,
                15,  # 15 knots, sail chicago suggested limit for inexperienced crew
                21,  # 21 knots, sail chicago sailing limit
            }
        end

        contex_dataset
          |> Dataset.new(["X", "Wind Speed", "Gusting To", "15", "21"])
    end


    @spec build_wind_speed_plot(list(Glerl.Core.Datapoint.t())) :: Plot
    def build_wind_speed_plot(glerl_datapoints) do
        glerl_datapoints = Enum.reverse(glerl_datapoints)
        dataset = convert_to_contex_data(glerl_datapoints)

        first_timestamp_utc = List.first(glerl_datapoints).timestamp
        last_timestamp_utc = List.last(glerl_datapoints).timestamp

        y_scale_max = glerl_datapoints |> max_wind_speed() |> calc_wind_range_from_max()
        y_scale = ContinuousLinearScale.new()
          |> ContinuousLinearScale.domain(0.0, y_scale_max)
          |> Scale.set_range(0.0, y_scale_max)
        y_scale = %{y_scale | interval_count: round(y_scale_max/5), interval_size: 5, display_decimals: 0}

        x_scale = Glerl.Web.Plots.TimeScale.new({first_timestamp_utc, last_timestamp_utc})

        options = [
            mapping: %{x_col: "X", y_cols: ["Wind Speed", "Gusting To", "15", "21"]},
            custom_y_scale:  y_scale,
            custom_x_scale: x_scale,
            legend_setting: :legend_none,
            axis_label_rotation: 45,
        ]

        Plot.new(dataset, LinePlot, 900, 500, options)
    end

    @spec build_wind_direction_plot(list(Glerl.Core.Datapoint.t())) :: Plot
    def build_wind_direction_plot(glerl_datapoints) do
        glerl_datapoints = Enum.reverse(glerl_datapoints)
        dataset = convert_to_contex_data(glerl_datapoints)

        first_timestamp_utc = List.first(glerl_datapoints).timestamp
        last_timestamp_utc = List.last(glerl_datapoints).timestamp

        y_scale_max = glerl_datapoints |> max_wind_speed() |> calc_wind_range_from_max()
        y_scale = ContinuousLinearScale.new()
          |> ContinuousLinearScale.domain(0.0, y_scale_max)
          |> Scale.set_range(0.0, y_scale_max)
        y_scale = %{y_scale | interval_count: round(y_scale_max/5), interval_size: 5, display_decimals: 0}

        x_scale = Glerl.Web.Plots.TimeScale.new({first_timestamp_utc, last_timestamp_utc})

        options = [
            mapping: %{x_col: "X", y_cols: ["Wind Speed", "Gusting To", "15", "21"]},
            custom_y_scale:  y_scale,
            custom_x_scale: x_scale,
            legend_setting: :legend_none,
            axis_label_rotation: 45,
        ]

        Plot.new(dataset, LinePlot, 900, 500, options)
    end
end
