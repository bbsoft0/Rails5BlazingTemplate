if ENV['RAILS_ENV'] != 'development'
  app_root = '/tmp/sockets'
  pidfile "/tmp/pids/puma.pid"
  state_path "/tmp/pids/puma.state"
  bind "unix://tmp/sockets/puma.sock"
  activate_control_app "unix://tmp/sockets/pumactl.sock"
  daemonize true
  workers 2
  threads 8, 16
  preload_app!

  on_worker_boot do
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.establish_connection
    end
  end

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect!
  end
else
  plugin :tmp_restart
end
