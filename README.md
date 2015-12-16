# Exeter

Potential issues:
* Guard: fsevent may not recognize proper path prefix. To fix:
 1. Go into ~/.rvm/gems/ruby-[version]@[gemset]/gems/listen-[version]/lib/listen/adapter/darwin.rb:42
 2. Edit "new_path" to be Pathname.new([path to app directory])
