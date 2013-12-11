class Customer < User

  has_and_belongs_to_many :businesses

  has_and_belongs_to_many :categories,
    join_table: "categories_customers"

  

  def update_categories category_ids
    self.category_ids = category_ids
  end

  def already_checked? category_id
    self.categories.include? category_id
  end

  # def filter_by_category_ids
  #   return true if current_customer.category_ids.include? business.category_id
  #   false
  # end

end
