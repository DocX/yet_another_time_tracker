require 'spec_helper'

describe Ui::YattController do

  describe "GET 'main'" do
    it "returns http success" do
      get 'main'
      response.should be_success
    end
  end

end
