module Cucumber::RbSupport::RbWorld
  alias :_pending :pending

  def pending
    pause

    _pending
  end
end

