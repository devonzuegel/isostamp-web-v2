require 'open3'

class Shell
  def initialize
    @commands = []
    @stdouts  = []
    @stderrs  = []
  end

  def commands
    @commands
  end

  def stdouts
    @stdouts
  end

  def stderrs
    @stderrs
  end

  def run(cmd, logger: false)
    validate_format(cmd)

    stdin, stdout, stderr = Open3.popen3(cmd)
    output, error = '', ''

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

    @commands += [ cmd    ]
    @stdouts  += [ output ]
    @stderrs  += [ error  ]

    successful
  end

  private

  def validate_format(cmd)
    if !cmd.ends_with?(';')
      raise ArgumentError, 'Please end all commands with a semi-colon'
    end
  end
end