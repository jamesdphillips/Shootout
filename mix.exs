defmodule Shootout.Mixfile do
  use Mix.Project

  def project do
    [ app: :shootout,
      version: "0.0.1",
      elixir: "> 0.10.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps do
    [
      {:jiffy, github: "davisp/jiffy"},
      {:mochijson2, github: "bjnortier/mochijson2"},
      {:poison, github: "devinus/poison"},
      {:message_pack, github: "mururu/msgpack-elixir"},
      {:msgpax, github: "lexmag/msgpax"},
      {:msgpack, github: "msgpack/msgpack-erlang"}
    ]
  end
end
