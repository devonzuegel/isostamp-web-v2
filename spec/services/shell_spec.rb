require 'rails_helper'

RSpec.describe Shell do
  before(:each) { @shell = described_class.new }

  it 'is initialized with empty results strings' do
    expect(@shell.commands).to eq []
    expect(@shell.stdouts).to  eq []
    expect(@shell.stderrs).to eq []
  end

  it 'saves the output of a command run' do
    str = 'hello there!'
    cmd = "echo #{str};"
    @shell.run(cmd)
    expect(@shell.stdouts).to  eq ["#{str}\n"]
    expect(@shell.commands).to eq [cmd]
  end

  it 'does not add stderrs for a non-erroring command run' do
    str = 'hello there!'
    @shell.run("echo #{str};")
    expect(@shell.stderrs).to eq ['']
  end

  it 'saves the stderrs of an erroring command run' do
    @shell.run('print hi;')
    expect(@shell.stderrs).to eq ["sh: print: command not found\n"]
  end

  it 'appends the output of multiple runs' do
    strs = %w[hi hola hallo]
    cmds = strs.map { |s| "echo #{s};" }
    cmds.each { |cmd| @shell.run(cmd) }
    expect(@shell.commands).to eq cmds
    expect(@shell.stdouts).to  eq strs.map { |s| "#{s}\n" }
    expect(@shell.stderrs).to eq strs.map { |_s| '' }
  end

  it 'appends the stderrs of multiple runs' do
    cmds = [
      'echo blah;',
      'print hello!;',
      'echo blah;'
    ]

    cmds.each { |cmd| @shell.run(cmd) }
    expect(@shell.stderrs).to eq [
      '',
      "sh: print: command not found\n",
      ''
    ]
  end

  it 'requires commands to end with semicolons' do
    expect { @shell.run('echo hi') }.to raise_error ArgumentError, 'Please end all commands with a semi-colon'
  end
end
