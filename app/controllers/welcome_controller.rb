class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [:visited]

  def home
  end

end
