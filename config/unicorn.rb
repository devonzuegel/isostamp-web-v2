worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection

  Que.wake_interval = (ENV['QUE_WAKE_INTERVAL'] || 10).to_i.seconds
  Que.mode          = (ENV['QUE_MODE']          || :async).to_sym
  Que.worker_count  = (ENV['QUE_WORKERS']       || 3).to_i

  Que.log_formatter = proc do |data|
    "Thread #{data[:thread]} experienced a #{data[:event]}".black
  end

  Que.error_handler = proc do |error, job|
    puts 'ERROR:'.red
    ap error
    puts 'JOB:'.red
    ap job
  end
end
