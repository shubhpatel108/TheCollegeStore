class BookGroup < ActiveRecord::Base
  attr_accessible :title, :author, :publisher, :books_attributes
  attr_accessible :image
  has_attached_file :image,:styles => { :small => "500x500<" }, :default_url => 'noimage.jpg',
  					:path => ":rails_root/public/assets/books/:basename.:extension",
  					:url => "/assets/books/:basename.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true
  validates :author, presence: true
  has_many :books, :dependent => :destroy
  accepts_nested_attributes_for :books
  before_create :set_image_name
  belongs_to :category

  def set_image_name
  	if not image_file_name.nil?
	  	extension = File.extname(image_file_name).downcase
	  	self.image.instance_write(:file_name, "#{self.title}#{extension}")
	  end
  end
end
