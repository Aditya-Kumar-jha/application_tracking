class Job < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :category, presence: true,
            :inclusion => { :in => %w(frontend backend web-developer) }
    validates :exp, presence: true,
            format: {with: /[0-9]+/, message: "Should be integer"},
            numericality: { greater_than: 0 }
    validate :status
end
