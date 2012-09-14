require 'cuke-pack/tasks'

task(:default).clear

task :preflight_check do
  task('cuke_pack:any_wip').invoke
end

task :default do
  task('cuke_pack:precommit').invoke
end

