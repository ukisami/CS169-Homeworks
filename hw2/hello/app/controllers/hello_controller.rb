class HelloController < ApplicationController
  def index
    @message="Hello!"
    @count=3
    @bonus="This message came from the controller."
  end
end
