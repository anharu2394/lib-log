class BooksController < ApplicationController
   before_action :authenticate_user!, :except => [:show, :index,:ranking,:search]
  def index
    a_products = []
    products = Book.all


    products.each do |product|
      if !product.reviews.average(:rate).nil?


      product_id_rate = {}
      product_id_rate[:id] = product.id
      # product_id_rate[:averaged_rate] = product.reviews.average(:rate)
      # binding.pry
      product_id_rate[:averaged_rate] = product.reviews.average(:rate)
      # binding.pry

        a_products << product_id_rate
      end

    end

      a_products = a_products.sort{|a,b| b[:averaged_rate] <=> a[:averaged_rate]}
    product_ids = []

    a_products.each do |product|
       product_ids << product[:id]
    end

    @ranking =[]

    product_ids.each do |id|
      book = Book.find(id)
      @ranking << book
    end

    # binding.pry
  end
  def show

    @book = Book.find(params[:id])
    @review = @book.reviews
  end
   def new
    @book = Book.new

  end
  def create
    @book =Book.create(create_params)
    # @book = Book.find(params[:book_id])
    redirect_to :action => "show",:id =>@book.id
  end
  def search
    unless params[:keyword] == ""
      if params[:keyword].present?
        @books = Book.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
      end
    else
    end
  end
def rank_create(type)
   user_details = UserDetail.where(type)
    rates = {}
    test = []
  user_details.each do |ud|
      user = ud.user
      reviews = user.reviews.group(:book_id).average(:rate)
      rates = rates.merge(reviews)
    end
    rates.each do |id,rate|
      rates_2 = {}
      rates_2[:id] = id
      rates_2[:rate] = rate.to_f.round
      test << rates_2
    end
    test = test.sort{|a,b| b[:rate] <=> a[:rate]}
    return test
end


  def ranking
    # users = []
    # user_detals1 = UserDetail.where(gender:"男")
    # user_details2 = UserDetail.where(gender:"女")
    # user_details3 = UserDetail.where(age:0..10 )

    @rates = rank_create(gender:"男")
    @rates2 = rank_create(gender:"女")
    @rates_age = rank_create(age:0..9)
    @rates_age2 = rank_create(age:10..19)
    @rates_age3 = rank_create(age:20..29)
    @rates_age4 = rank_create(age:30..39)
    @rates_age5 = rank_create(age:40..49)
    @rates_age6 = rank_create(age:50..59)
    @rates_age7 = rank_create(age:60..69)
    @rates_age8 = rank_create(age:70..79)
    @rates_age9 = rank_create(age:80..89)
    @rates_age10 = rank_create(age:90..99)
    @rates_age11= rank_create(age:100..200)
    # users << user_detals1
    # users<< user_detals2
    # users << user_detals3

    # rates1 = {}
    # test1 = []
    # rates2 = {}
    # test2 = []
    # rates3 = {}
    # test3 = []
    # # 男性


    # user_details1.each do |ud|
    #   user = ud.user
    #   reviews = user.reviews.group(:book_id).average(:rate)
    #   rates1= rates1.merge(reviews)
    # end
    # rates1.each do |id,rate|
    #   rates_2 = {}
    #   rates_2[:id] = id
    #   rates_2[:rate] = rate.to_f.round
    #   test1 << rates_2
    # end
    # test1 = test1.sort{|a,b| b[:rate] <=> a[:rate]}
    # @rates1 = test1


    # # 女性
    # user_details2.each do |ud|
    #   user = ud.user
    #   reviews = user.reviews.group(:book_id).average(:rate)
    #   rates2= rates2.merge(reviews)
    # end
    # rates2.each do |id,rate|
    #   rates_2 = {}
    #   rates_2[:id] = id
    #   rates_2[:rate] = rate.to_f.round
    #   test2 << rates_2
    # end
    # test2 = test2.sort{|a,b| b[:rate] <=> a[:rate]}
    # @rates2 = test2




  end


  private
  def create_params
    return params.require(:book).permit(:title,:writer)
  end
end
