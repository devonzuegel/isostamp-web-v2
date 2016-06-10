require 'rails_helper'

RSpec.describe Shell do
  before(:each) { @shell = Shell.new }

  it 'should be initialized with empty results strings' do
    expect(@shell.commands).to eq []
    expect(@shell.outputs).to  eq []
    expect(@shell.errors).to   eq []
  end

  it 'should save the output of a command run' do
    str = 'hello there!'
    cmd = "echo #{str};"
    @shell.run(cmd)
    expect(@shell.outputs).to  eq [ "#{str}\n" ]
    expect(@shell.commands).to eq [ cmd        ]
  end

  it 'should not add errors for a non-erroring command run' do
    str = 'hello there!'
    @shell.run("echo #{str};")
    expect(@shell.errors).to eq ['']
  end

  it 'should save the errors of an erroring command run' do
    @shell.run("print hi;")
    expect(@shell.errors).to eq ["sh: print: command not found\n"]
  end

  it 'should append the output of multiple runs' do
    strs = %w(hi hola hallo)
    cmds = strs.map { |s| "echo #{s};"}
    cmds.each { |cmd| @shell.run(cmd) }
    expect(@shell.commands).to eq cmds
    expect(@shell.outputs).to  eq strs.map { |s| "#{s}\n" }
    expect(@shell.errors).to   eq strs.map { |s| '' }
  end

  it 'should append the errors of multiple runs' do
    cmds = [
      'echo blah;',
      'print hello!;',
      'echo blah;'
    ]

    cmds.each { |cmd| @shell.run(cmd) }
    expect(@shell.errors).to eq [
      '',
      "sh: print: command not found\n",
      ''
    ]
  end
end
