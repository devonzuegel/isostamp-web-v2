require 'open3'

class Shell
  def initialize
    @commands = []
    @outputs  = []
    @errors   = []
  end

  def commands
    @commands
  end

  def outputs
    @outputs
  end

  def errors
    @errors
  end

  def run(cmd, logger: false)
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
    @outputs  += [ output ]
    @errors   += [ error  ]

    successful
  end
end