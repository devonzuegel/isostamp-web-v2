def current_branch
  `git rev-parse --abbrev-ref HEAD`.chomp
end

def permission_granted?(question)
  loop do
    print "#{question} (Y/N)  "
    answer = gets.chomp
    return true  if answer.downcase == 'y'
    return false if answer.downcase == 'n'
    puts '  > Please respond with Y or N'
  end
end

def deploy
  if current_branch != 'master'
    puts "Your current branch is `#{current_branch}`. Merge any " \
          'changes you wish to deploy to isostamp-staging onto the ' \
          '`master` branch, then re-run this script on `master`.'
    return
  end

  if permission_granted?('Precompile assets?')
    puts 'Precompiling assets...'
    `bundle exec rake assets:precompile`
    puts 'Committing...'
    puts `git add .`
    puts `git commit -m 'Precompiles assets'`
  end

  if permission_granted?('Push to remote staging branch?')
    puts 'Pushing...'
    puts `git push --no-verify -f`
  else
    puts 'Cancelling deployment...'
    return
  end

  if permission_granted?('Run migrations?')
    puts 'Running migrations...'
    puts `/usr/local/heroku/bin/heroku run rake db:migrate --app isostamp-staging`
  end

  if permission_granted?('Open heroku logs?')
    puts 'Opening heroku logs...'
    exec '/usr/local/heroku/bin/heroku logs -t --app isostamp-staging'
  end
end

deploy