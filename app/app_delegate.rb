class AppDelegate < PM::Delegate
  include CDQ
  status_bar true, animation: :none

  def on_load(app, options)
    cdq.setup
    return true if RUBYMOTION_ENV == "test"
    open HomeScreen.new(nav_bar: true)
  end

end
