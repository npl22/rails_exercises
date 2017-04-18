# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: ['PENDING', 'APPROVED', 'DENIED']
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def approve!
    CatRentalRequest.transaction do
      update(status: 'APPROVED')
      overlapping_pending_requests.each(&:deny!)
    end
  end

  def deny!
    update(status: 'DENIED')
  end

  def pending?
    status == 'PENDING'
  end

  private

  def overlapping_requests
    where_string = <<-SQL
      cat_id = #{cat_id}
      AND (start_date BETWEEN '#{start_date}' AND '#{end_date}'
            OR end_date BETWEEN '#{start_date}' AND '#{end_date}')
    SQL
    CatRentalRequest.where(where_string)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:base] << "There is another rental for that time"
    end
  end
end
