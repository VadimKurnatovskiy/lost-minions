# frozen_string_literal: true

shared_context :frozen_time do
  let(:current_time) { Time.new(2020, 4, 4, 14, 0, 0, '+03:00').in_time_zone('Moscow') }

  before { Timecop.freeze(current_time) }

  after { Timecop.return }
end
