require 'active_support'
require 'active_support/core_ext'
require 'webrick'
require_relative '../lib/Phase10/controller_base'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
class Human < SQLObject
  @table_name = "humans"
  has_many( :cats,
  class_name: "Cat",
  foreign_key: :owner_id,
  primary_key: :id
  )
end

class Cat < SQLObject
  belongs_to(:owner,
    class_name: "Human",
    foreign_key: :owner_id,
    primary_key: :id)


  



  # def self.all
  #   @cat ||= []
  # end

  # def initialize(params = {})
  #   params ||= {}
  #   @name, @owner = params["name"], params["owner"]
  # end
  #
  # def save
  #   return false unless @name.present? && @owner.present?
  #   Cat.all << self
  #   true
  # end
  #
  # def inspect
  #   { name: name, owner: owner }.inspect
  # end
end
class HumansController < Phase10::ControllerBase
end

class CatsController < Phase10::ControllerBase


  def create

    @cat = Cat.new(params["cat"])
    if @cat.save
      flash[:notice] = ["Cat saved"]

      redirect_to("/cats")
    else
      flash.now[:notice] = ["Cat is invalid"]

      render :new
    end
  end

  def index
    @cats = Cat.all

    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  case [req.request_method, req.path]
  when ['GET', '/cats']
    CatsController.new(req, res, {}).index
  when ['POST', '/cats']
    CatsController.new(req, res, {}).create
  when ['GET', '/cats/new']
    CatsController.new(req, res, {}).new
  end
end

trap('INT') { server.shutdown }
server.start
