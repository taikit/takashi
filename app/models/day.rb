class Day < ActiveRecord::Base
  belongs_to :plan
  validate :past_check

  def past_check
    if self.met_at < Time.now
      errors.add('', 'must be choosed future date')
    end
  end
end