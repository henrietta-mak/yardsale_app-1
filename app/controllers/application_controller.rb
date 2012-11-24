class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  
    include SessionsHelper
end
