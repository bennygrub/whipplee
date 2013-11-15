class PagesController < ApplicationController
  def home
  end

  def about
  	api = ContextIO.new('p3o3c7vm', '8kYkj7Qv9xKeVitj')
  	@response = api.connect_tokens.create("http://localhost:3000", options = {'email' => 'blgruber@gmail.com'})

  end

  def contact
  end
end
