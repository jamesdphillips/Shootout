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

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      { :json, github: "cblage/elixir-json"},
 #     { :jazz, github: "meh/jazz"},
      { :jsex, github: "talentdeficit/jsex"},
      {:jiffy, github: "davisp/jiffy"},
      {:mochijson2, github: "bjnortier/mochijson2"}
    ]
  end
end
