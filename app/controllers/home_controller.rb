class HomeController < ApplicationController
  def index
  	@popular_products = Product.all.where('backers_total >? and active =?',0,true).order(:backers_total).limit(3)
  	@recommended_products = Product.all.where(:active=>true).limit(3)
  end
end
