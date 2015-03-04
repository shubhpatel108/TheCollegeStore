class BookGroup < ActiveRecord::Base
  attr_accessible :title, :author, :publisher, :books_attributes
  attr_accessible :image
  has_attached_file :image,:styles => { :thumbnail => "180x230" }, :default_url => 'noimage.jpg',
  					:path => ":rails_root/public/assets/books/:basename.:extension",
  					:url => "/assets/books/:basename.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true
  validates :author, presence: true
  has_many :books, dependent: :destroy
  accepts_nested_attributes_for :books
  after_create :set_image_name
  belongs_to :category
  attr_accessible :category_id

  has_many :wishlists, :dependent => :destroy,
                       :foreign_key => "book_group_id"
  has_many :wishers, :through => :wishlists, :source => :wisher
  has_one :blogbook
  has_and_belongs_to_many :college, :join_table => :college_books

  def set_image_name
  	if not image_file_name.nil?
	  	extension = File.extname(image_file_name).downcase
	  	self.image.instance_write(:file_name, "#{self.title}_#{self.id}#{extension}")
      self.save!
	  end
  end

  def slug
    title.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end

  def total_stock
    self.books.where(:reserved => false).count
  end

  def stock(college_id)
    self.books.where(:college_id => college_id, :reserved => false).count
  end

  def min_price
    self.books.map(&:price).compact.min
  end

  def college_sold_stock(college_id)
    self.books.where(:college_id => college_id, :reserved => true).count
  end

  def min_price
    self.books.map(&:price).compact.min
  end

  def last_updated(college_id)
    books = self.books.where(:college_id => college_id)
    if not books.empty?
      books.map(&:updated_at).compact.max
    else
      Time.at(0)
    end
  end

  def last_updated_on
    books = self.books
    if not books.empty?
      books.map(&:updated_at).compact.max
    else
      Time.at(0)
    end
  end
end
