class RemoveFile < Que::Job
  @retry_interval = 5

  def run(filepath)
    puts "Removing file '#{filepath}'...".blue
    stdin, stdout, stderr = Open3.popen3("rm #{filepath};")
  end
end