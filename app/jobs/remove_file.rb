class RemoveFile < Que::Job
  @retry_interval = 5

  def run(filepath)
    puts "Removing file '#{filepath}'...".blue

    puts "Running 'rm #{filepath};'".blue
    shell.run("rm #{filepath};", logger: true)

    puts "Running 'ls ./tmp;'".blue
    shell.run("ls ./tmp;", logger: true)
  end

  private

  def shell
   @shell ||= Shell.new
  end
end