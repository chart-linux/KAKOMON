class PastQuestion < ActiveRecord::Base
  belongs_to :exam_date
  has_many :tag_relations
  has_many :tags, through: :tag_relations

  validates :subject, :year, :term, :file_path, :data_type, :added_time, presence: true
  validates :subject, length: { maximum: 100 }
  validates :kana, length: { maximum: 100 }
  validates :teacher, length: { maximum: 20 }
  validates :file_path, lenth: { maximum: 100 }
  validate :check_file_path

  mount_uploader :file_path, PastQuestion 

  private
  def check_file_path
    data_type = File.extname("#{file_path}")
    path = Rails.root.join("app/assets/images", file_path)
    errors.add(:file_path, :invalid) unless data_type =~ /[jJ][pP].?[gG]\z|[pP][nN][gG]\z|[pP][dD][fF]\z/
    errors.add(:file_path, :file_not_exist) unless File.exist?(path)
  end
end
