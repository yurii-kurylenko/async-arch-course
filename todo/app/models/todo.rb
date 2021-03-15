class Todo < ApplicationRecord
  include AASM

  aasm column: :state do
    state :new, initial: true
    state :closed, :in_progress
  end

  belongs_to :user
end
