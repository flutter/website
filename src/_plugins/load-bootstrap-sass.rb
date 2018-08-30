# Register path to bootstrap-sass for bootstrap 3
# TODO: drop if/when we migrate to bootstrap 4

Jekyll::Assets::Utils.activate "bootstrap-sass" do
  Bootstrap.load!
end
