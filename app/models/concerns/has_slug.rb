module HasSlug
  extend ActiveSupport::Concern

  included do
    before_validation :set_slug_if_empty

    validates_presence_of :title, :slug
    validates_uniqueness_of :slug
  end

  def set_slug_if_empty
    if self.slug.empty?
      self.slug = self.title.parameterize
    end
  end
end
