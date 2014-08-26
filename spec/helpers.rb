module Helpers

  def expect_admin(script, boolean)
    expect(script).to receive(:admin_session?).and_return(boolean)
  end

end
