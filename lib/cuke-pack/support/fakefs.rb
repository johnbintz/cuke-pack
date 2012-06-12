# Enable FakeFS support in scenarios tagged @fakefs

require 'fakefs/safe'

Before('@fakefs') do
  FakeFS.activate!
end

After('@fakefs') do
  ensure_mocha if respond_to?(:ensure_mocha)

  FakeFS::FileSystem.clear
  FakeFS.deactivate!
end

