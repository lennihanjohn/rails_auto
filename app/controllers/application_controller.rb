class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionView::Helpers::TagHelper
  include ActionView::Context
end
