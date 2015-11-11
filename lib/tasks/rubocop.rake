require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.formatters = %w(fuubar html)
  task.options = %w(-o rubocop.html)
end
