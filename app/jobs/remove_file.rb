class RemoveFile < Que::Job
  @retry_interval = 5

  def run(filepath)
    puts "Removing file '#{filepath}'...".blue

    puts "Running 'rm #{filepath};'".blue
    shell.run("rm #{filepath};")

    puts "Running 'ls ./tmp;'".blue
    shell.run("ls ./tmp;")

    puts "STDOUT:".blue
    ap shell.stdouts.as_json
    puts "STDERR:".blue
    ap shell.stderrs.as_json
  end

  private

  def shell
   @shell ||= Shell.new
  end
end