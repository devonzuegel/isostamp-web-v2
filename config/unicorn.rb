worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection

  Que.wake_interval = (ENV['QUE_WAKE_INTERVAL'] || 10).to_i.seconds
  Que.mode          = (ENV['QUE_MODE']          || :async).to_sym
  Que.worker_count  = (ENV['QUE_WORKERS']       || 1).to_i
end
