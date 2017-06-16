def permission_granted?(question)
  loop do
    print "#{question} (Y/N)  "
    answer = gets.chomp
    return true  if answer.downcase == 'y'
    return false if answer.downcase == 'n'
    puts '  > Please respond with Y or N'
  end
end

if permission_granted?('Promote `isostamp-staging` (staging) to `isostamp` (production)?')
  puts 'Promoting...'
  puts `heroku pipelines:promote --app isostamp-staging`
  puts 'Migrating...'
  puts `heroku run rake db:migrate --app isostamp`
end

if permission_granted?('Open heroku logs?')
  puts 'Opening heroku logs...'
  exec 'heroku logs -t --app isostamp'
end
