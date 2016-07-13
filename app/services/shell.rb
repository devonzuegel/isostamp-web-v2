require 'open3'

class Shell
  attr_reader :commands, :stdouts, :stderrs

  def initialize
    @commands = []
    @stdouts  = []
    @stderrs  = []
  end

  def run(cmd, logger: false)
    validate_format(cmd)

    _, stdout, stderr = Open3.popen3(cmd)
    output = ''
    error  = ''

    stdout.each_line do |line|
      output << line
      print line.light_green if logger
    end

    successful = true
    stderr.each_line do |line|
      error << line
      print line.light_magenta if logger
      successful = false if !line.blank?
    end

    @commands += [cmd]
    @stdouts  += [output]
    @stderrs  += [error]

    successful
  end

  private

  def validate_format(cmd)
    return if cmd.ends_with?(';')
    fail ArgumentError, 'Please end all commands with a semi-colon'
  end
end